import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:product_check/src/models/record.dart';
import 'package:product_check/src/utils/component_utils.dart';

import 'nfc_writer.dart';

class RecordFormPage extends StatefulWidget {
  @override
  _RecordFormPageState createState() => _RecordFormPageState();
}

class _RecordFormPageState extends State<RecordFormPage> {
  var manufacturerController = TextEditingController();
  var productCodeController = TextEditingController();

  /*
  NFCWriter(
                                        title: "NFC page",
                                        record: Record("212321", "22342643622")
   */

  navigateToWriteNFCPage(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NFCWriter(
                  title: "NFC page",
                  record: Record(
                      productCodeController.text, manufacturerController.text),
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFfbfdfd),
        body: new GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Padding(
                padding: const EdgeInsets.fromLTRB(32, 32, 32, 0),
                child: Column(children: [
                  SizedBox(
                      height: ComponentUtils.screenHeightPercent(context, 2)),
                  new SizedBox(
                      width: 40.0,
                      height: 40.0,
                      child: MaterialButton(
                        child: Image.asset(
                          'assets/back_icon_centered.png',
                        ),
                        shape: RoundedRectangleBorder(
                            side:
                                BorderSide(width: 1, color: Color(0x77BDBDBD)),
                            borderRadius: BorderRadius.circular(10)),
                        onPressed: () => Navigator.pop(context),
                      )),
                  SizedBox(
                      height: ComponentUtils.screenHeightPercent(context, 4)),
                  new Text("Save data to NFC tag",
                      style: new TextStyle(
                          fontSize: 22.0,
                          fontFamily: 'ProductSans',
                          fontWeight: FontWeight.bold)),
                  Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: new Text(
                          "Insert manufacturer and product code and save data to tag.",
                          style: new TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey,
                            fontFamily: 'ProductSans',
                          ))),
                  SizedBox(
                      height: ComponentUtils.screenHeightPercent(context, 13)),
                  Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.blueAccent, Color(0xFF84d2f3)]),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: ComponentUtils.boxShadow(
                              color: Color(0xAA84d2f3))),
                      height: ComponentUtils.screenHeightPercent(context, 40),
                      width: double.maxFinite,
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                new Text("Manufacturer code:",
                                    textAlign: TextAlign.left,
                                    style: new TextStyle(
                                      fontSize: 18.0,
                                      color: Color(0xFF515151),
                                      fontFamily: 'ProductSans',
                                    )),
                                SizedBox(height: 5),
                                TextFormField(
                                    keyboardType: TextInputType.text,
                                    controller: manufacturerController,
                                    decoration: InputDecoration(
                                      labelText: "Enter code",
                                      fillColor: Colors.white,
                                      labelStyle: TextStyle(
                                        color: Colors.black,
                                      ),
                                      border: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(25.0),
                                        borderSide: new BorderSide(),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(25.0),
                                        borderSide: new BorderSide(),
                                      ),
                                    )),
                                SizedBox(
                                    height: ComponentUtils.screenHeightPercent(
                                        context, 5)),
                                new Text("Product code:",
                                    textAlign: TextAlign.left,
                                    style: new TextStyle(
                                      fontSize: 18.0,
                                      color: Color(0xFF515151),
                                      fontFamily: 'ProductSans',
                                    )),
                                SizedBox(height: 5),
                                TextFormField(
                                    keyboardType: TextInputType.text,
                                    controller: productCodeController,
                                    decoration: InputDecoration(
                                      labelText: "Enter code",
                                      fillColor: Colors.white,
                                      labelStyle: TextStyle(
                                        color: Colors.black,
                                      ),
                                      border: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(25.0),
                                        borderSide: new BorderSide(),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(25.0),
                                        borderSide: new BorderSide(),
                                      ),
                                    )),
                              ]))),
                  SizedBox(
                      height: ComponentUtils.screenHeightPercent(context, 10)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                        height: 80,
                        child: Image.asset(
                          'assets/scan_icon.png',
                          height: 40,
                        ),
                        onPressed: productCodeController.text == "" ||
                                manufacturerController.text == ""
                            ? null
                            : () => navigateToWriteNFCPage(context),
                        padding: EdgeInsets.all(20.0),
                        color: Color(0xFFfedf85),
                        disabledColor: Color(0xFFE0E0E0),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                    ],
                  ),
                ], crossAxisAlignment: CrossAxisAlignment.start))));
  }
}
