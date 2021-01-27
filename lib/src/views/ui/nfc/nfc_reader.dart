import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nfc_in_flutter/nfc_in_flutter.dart';
import 'package:product_check/src/models/record.dart';
import 'package:product_check/src/utils/component_utils.dart';

class NFCReader extends StatefulWidget {
  NFCReader({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _NFCReaderState createState() => _NFCReaderState();
}

class _NFCReaderState extends State<NFCReader> {
  bool _supportsNFC = false;
  String _errorMessage;

  StreamSubscription<NDEFMessage> _stream;

  @override
  void initState() {
    super.initState();
    initNFC();
  }

  void initNFC() {
    NFC.isNDEFSupported.then((bool isSupported) {
      setState(() {
        _supportsNFC = isSupported;
      });
    });
    scanNFC();
  }

  void _handleError(String message) {
    _stream?.cancel();
    setState(() {
      _errorMessage = message;
      _stream = null;
    });
    scanNFC();
  }

  void _handlePayload(String payload) {
    try {
      Navigator.pop(context, Record.fromNFCPayload(payload));
    } catch (e) {
      setState(() {
        _errorMessage = "Wrong nfc format";
      });
    }
  }

  void scanNFC() {
    setState(() {
      _stream = NFC.readNDEF().listen((NDEFMessage message) {
        if (message.isEmpty) {
          _handleError("Read empty NDEF message");
          return;
        }
        _handlePayload(message.records.first.payload);
      }, onError: (error) {
        if (error is NFCUserCanceledSessionException) {
          _handleError("User canceled");
        } else if (error is NFCSessionTimeoutException) {
          _handleError("Session timed out");
        } else {
          _handleError("Error: $error");
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _stream?.cancel();
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
                  SizedBox(
                      height: ComponentUtils.screenHeightPercent(context, 20)),
                  Padding(
                      padding: EdgeInsets.all(16),
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: ComponentUtils.boxShadow()),
                          height:
                              ComponentUtils.screenHeightPercent(context, 40),
                          child: Padding(
                              padding:
                                  EdgeInsets.fromLTRB(32.0, 32.0, 32.0, 16.0),
                              child: Column(children: [
                                Center(
                                    child: Image.asset(
                                  'assets/scan_icon.png',
                                  height:  ComponentUtils.screenHeightPercent(context, 20),
                                  width:  ComponentUtils.screenHeightPercent(context, 20),
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
                                if (_errorMessage != null)
                                  Center(
                                      child: new Text(
                                    _errorMessage,
                                    style: TextStyle(color: Colors.red),
                                  )),
                                SizedBox(height: 5),
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
