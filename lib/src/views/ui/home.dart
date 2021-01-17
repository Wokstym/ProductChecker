import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nfc_in_flutter/nfc_in_flutter.dart';
import 'package:product_check/src/models/record.dart';
import 'package:product_check/src/views/ui/record_editor.dart';
import 'package:velocity_x/velocity_x.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _supportsNFC = false;
  Record _valueRed;
  String _errorMessage;

  StreamSubscription<NDEFMessage> _stream;
  RecordEditor recordEditor;

  bool _hasClosedWriteDialog = false;

  @override
  void initState() {
    super.initState();
    recordEditor = new RecordEditor();
    NFC.isNDEFSupported.then((bool isSupported) {
      setState(() {
        _supportsNFC = isSupported;
      });
    });
  }

  /* writing */

  void _write(BuildContext context, Record payload) async {
    List<NDEFRecord> records = [
      NDEFRecord.plain(payload.getNFCFormattedString())
    ];
    NDEFMessage message = NDEFMessage.withRecords(records);

    // Show dialog on Android (iOS has it's own one)
    if (Platform.isAndroid) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Scan the tag you want to write to"),
          actions: <Widget>[
            FlatButton(
              child: const Text("Cancel"),
              onPressed: () {
                _hasClosedWriteDialog = true;
                _stream?.cancel();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    }

    // Write to the first tag scanned
    await NFC.writeNDEF(message).first;
    if (!_hasClosedWriteDialog) {
      Navigator.pop(context);
    }
    _errorMessage = null;
  }

  /* ===== */

  void _handleError(String message) {
    setState(() {
      _errorMessage = message;
      _valueRed = null;
      _stream = null;
    });
    print(message);
  }

  void _handlePayload(String payload) {
    setState(() {
      _errorMessage = null;
      _valueRed = null;
      try {
        _valueRed = Record.fromNFCPayload(payload);
      } catch (_) {
        _errorMessage = "Wrong nfc format";
      }
      _stream = null;
    });
    print(payload);
  }

  /* reading */
  void _startScanning() {
    setState(() {
      _stream = NFC.readNDEF().listen((NDEFMessage message) {
        if (message.isEmpty) {
          _handleError("Read empty NDEF message");
          return;
        }
        print("Read NDEF message with ${message.records.length} records");

        _handlePayload(message.records.first.payload);
      }, onError: (error) {
        setState(() {
          _stream = null;
        });
        if (error is NFCUserCanceledSessionException) {
          _handleError("user canceled");
        } else if (error is NFCSessionTimeoutException) {
          _handleError("session timed out");
        } else {
          _handleError("error: $error");
        }
      }, onDone: () {
        setState(() {
          _stream = null;
        });
      });
    });
  }

  void _stopScanning() {
    _stream?.cancel();
    setState(() {
      _stream = null;
    });
  }

  void _toggleScan() {
    if (_stream == null) {
      _errorMessage = null;
      _startScanning();
    } else {
      _stopScanning();
    }
  }

  /* ===== */

  @override
  void dispose() {
    super.dispose();
    _stopScanning();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Vx.gray300,
      body: SingleChildScrollView(
        child: ZStack([
          VxBox()
              .blue600
              .size(context.screenWidth, context.percentHeight * 30)
              .make(),
          VStack([
            (context.percentHeight * 10).heightBox,
            "Product line checker"
                .text
                .xl4
                .white
                .bold
                .center
                .makeCentered()
                .py16(),
            (context.percentHeight * 5).heightBox,
            VxBox(
                    child: VStack([
              "NFC readings".text.gray700.xl2.semiBold.makeCentered(),
              10.heightBox,
              if (!_supportsNFC)
                "NFC is not detected - check if your device supports it and turn it on"
                    .text
                    .bold
                    .center
                    .xl
                    .makeCentered()
              else if (_stream != null)
                CircularProgressIndicator().centered()
              else if (_valueRed != null)
                showNfcDetails(),
              Expanded(child: Container()),
              if (_errorMessage != null) _errorMessage.text.makeCentered(),
            ]))
                .p16
                .white
                .size(context.screenWidth, context.percentHeight * 18)
                .rounded
                .shadowXl
                .make()
                .p16(),
            30.heightBox,
            if (_supportsNFC)
              VStack(
                [
                  FlatButton.icon(
                    onPressed: _toggleScan,
                    color: Colors.red,
                    shape: Vx.roundedSm,
                    icon: Icon(Icons.scanner, color: Colors.white),
                    label: _stream != null
                        ? "Stop reading".text.white.make()
                        : "Start reading".text.white.make(),
                  ).centered().h(50),
                  30.heightBox,
                  getNumberField(
                      "Manufacturer code", recordEditor.manufacturerCode),
                  30.heightBox,
                  getNumberField("Product code", recordEditor.productCode),
                  30.heightBox,
                  if (recordEditor.areBothFieldsFilled())
                    HStack(
                      [
                        FlatButton.icon(
                          onPressed: () =>
                              _write(context, recordEditor.getRecord()),
                          color: Colors.green,
                          shape: Vx.roundedSm,
                          icon: Icon(Icons.call_merge_outlined,
                              color: Colors.white),
                          label: "Write NFC".text.white.make(),
                        ).h(50),
                      ],
                      alignment: MainAxisAlignment.spaceAround,
                      axisSize: MainAxisSize.max,
                    ),
                ],
                alignment: MainAxisAlignment.center,
                axisSize: MainAxisSize.max,
              ),
          ]).p16()
        ]),
      ),
    );
  }

  showNfcDetails() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(
          20,
          0,
          0,
          0,
        ),
        child: VStack([
          ("Manufacturer code: " + _valueRed.manufacturerCode)
              .text
              .bold
              .xl
              .make(),
          ("Product code: " + _valueRed.productCode).text.bold.xl.make()
        ]));
  }

  Material getNumberField(String hintCode, TextEditingController controller) {
    return Material(
        elevation: 20.0,
        shadowColor: Colors.black,
        borderRadius: BorderRadius.circular(25.0),
        child: VStack([
          TextFormField(
            keyboardType: TextInputType.number,
            controller: controller,
            decoration: InputDecoration(
              hintText: hintCode,
              fillColor: Colors.white,
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(),
              ),
            ),
          ),
        ]));
  }
}
