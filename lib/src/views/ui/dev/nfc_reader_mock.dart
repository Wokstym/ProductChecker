
import 'package:flutter/material.dart';
import 'package:product_check/src/models/record.dart';
import 'package:product_check/src/utils/component_utils.dart';

class NFCMockReader extends StatefulWidget {
  NFCMockReader({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _NFCMockReaderState createState() => _NFCMockReaderState();
}

class _NFCMockReaderState extends State<NFCMockReader> {
  final productCodeController = TextEditingController();
  final manufacturerCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initNFC();
  }

  void initNFC() {}

  @override
  void dispose() {
    super.dispose();
    productCodeController.dispose();
    manufacturerCodeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF7FAFC),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    children: [
                      SizedBox(
                          height:
                              ComponentUtils.screenHeightPercent(context, 20)),
                      Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(children: [
                            Padding(
                                padding:
                                    EdgeInsets.fromLTRB(32.0, 32.0, 32.0, 16.0),
                                child: Column(children: [
                                  TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: productCodeController,
                                      decoration: InputDecoration(
                                        hintText: "ENTER PRODUCER",
                                        fillColor: Colors.white,
                                        border: new OutlineInputBorder(
                                          borderRadius:
                                              new BorderRadius.circular(25.0),
                                          borderSide: new BorderSide(),
                                        ),
                                      )),
                                  TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: manufacturerCodeController,
                                      decoration: InputDecoration(
                                        hintText: "ENTER MANUFACTURER",
                                        fillColor: Colors.white,
                                        border: new OutlineInputBorder(
                                          borderRadius:
                                              new BorderRadius.circular(25.0),
                                          borderSide: new BorderSide(),
                                        ),
                                      ))
                                ]))
                          ])),
                      SizedBox(
                          height:
                              ComponentUtils.screenHeightPercent(context, 20)),
                      Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: MaterialButton(
                            height: 80,
                            minWidth: 200,
                            child: Text(
                              "Wróc mockowane dane",
                            ),
                            onPressed: () => Navigator.pop(
                                context,
                                Record.fromNFCPayload(
                                    productCodeController.text +
                                        ";" +
                                        manufacturerCodeController.text)),
                            padding: EdgeInsets.all(20.0),
                            color: Colors.greenAccent,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                          )),
                      Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: MaterialButton(
                            height: 80,
                            minWidth: 200,
                            child: Image.asset('assets/close_icon.png'),
                            onPressed: () => Navigator.pop(context, null),
                            padding: EdgeInsets.all(20.0),
                            color: Color(0xFFFED7D7),
                            textColor: new Color(0xFFF56565),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                          )),
                    ],
                  )),
            ],
            alignment: AlignmentDirectional.topStart,
            fit: StackFit.loose,
            overflow: Overflow.clip,
          ),
        ));
  }
}
