import 'package:flutter/material.dart';
import 'package:nfc_in_flutter/nfc_in_flutter.dart';
import 'package:product_check/src/models/record.dart';
import 'package:product_check/src/utils/component_utils.dart';

class NFCWriter extends StatefulWidget {
  NFCWriter({Key key, this.title, @required this.record}) : super(key: key);

  final String title;
  final Record record;

  @override
  _NFCWriterState createState() => _NFCWriterState();
}

class _NFCWriterState extends State<NFCWriter> {
  bool _supportsNFC = false;

  @override
  void initState() {
    super.initState();
    NFC.isNDEFSupported.then((bool isSupported) {
      setState(() {
        _supportsNFC = isSupported;
      });
    });
    writeToNFCTag();
  }

  void writeToNFCTag() async {
    List<NDEFRecord> records = [
      NDEFRecord.plain(widget.record.getNFCFormattedString())
    ];
    NDEFMessage message = NDEFMessage.withRecords(records);

    Future.delayed(const Duration(milliseconds: 500), () {
      NFC.writeNDEF(message, once: true).listen((NDEFTag tag) {
        Navigator.pop(context);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7FAFC),
      body: Stack(
        children: [
          Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                children: [
                  SizedBox(height: ComponentUtils.screenHeightPercent(context, 20)),
                  Padding(
                      padding: EdgeInsets.all(16),
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: ComponentUtils.boxShadow()),
                          height: ComponentUtils.screenHeightPercent(context, 50),
                          child: Padding(
                              padding:
                                  EdgeInsets.fromLTRB(32.0, 32.0, 32.0, 16.0),
                              child: Column(children: [
                                Center(
                                    child: Image.asset(
                                  'assets/scan_icon.png',
                                  height: 200,
                                  width: 200,
                                )),
                                new Text(
                                    !_supportsNFC
                                        ? "Turn on your NFC"
                                        : "Hold your phone near nfc tag ",
                                    textAlign: TextAlign.center,
                                    style: new TextStyle(
                                      fontSize: 22.0,
                                      fontFamily: 'ProductSans',
                                    )),
                                Expanded(child: Container()),
                                Column(children: [
                                  new Text(
                                      "Manufacturer: " +
                                          widget.record.manufacturerCode,
                                      textAlign: TextAlign.center,
                                      style: new TextStyle(
                                        fontSize: 18.0,
                                        fontFamily: 'ProductSans',
                                      )),
                                  new Text(
                                      "Product code: " +
                                          widget.record.productCode,
                                      textAlign: TextAlign.center,
                                      style: new TextStyle(
                                        fontSize: 18.0,
                                        fontFamily: 'ProductSans',
                                      ))
                                ]),
                                SizedBox(height: 10),
                              ])))),
                  Expanded(child: Container()),
                  Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: MaterialButton(
                        height: 80,
                        minWidth: 200,
                        child: Image.asset('assets/close_icon.png'),
                        onPressed: () => Navigator.pop(context),
                        padding: EdgeInsets.all(20.0),
                        color: Color(0xFFFED7D7),
                        textColor: new Color(0xFFF56565),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      )),
                ],
              ))
        ],
        alignment: AlignmentDirectional.topStart,
        fit: StackFit.loose,
        overflow: Overflow.clip,
      ),
    );
  }
}
