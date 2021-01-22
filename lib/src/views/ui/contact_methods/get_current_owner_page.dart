import 'package:flutter/material.dart';
import 'package:product_check/src/models/record.dart';
import 'package:product_check/src/services/base_product_management_service.dart';
import 'package:product_check/src/utils/component_utils.dart';

import '../dev/nfc_reader_mock.dart';

class CurrentOwnerPage extends StatefulWidget {
  CurrentOwnerPage({Key key, this.title, this.productManagementService}) : super(key: key);
  final String title;
  final BaseProductManagementService productManagementService;

  @override
  _CurrentOwnerPageState createState() => _CurrentOwnerPageState(productManagementService);
}

class _CurrentOwnerPageState extends State<CurrentOwnerPage> {
  final BaseProductManagementService contractService;
  String productOwner;
  Record nfcRecord;
  bool loading = false;

  _CurrentOwnerPageState(this.contractService);

  getTextInputData() async {
    setState(() {
      loading = true;
    });
    String result = await contractService
        .getCurrentOwnerAddress(BigInt.parse(nfcRecord.productCode));
    setState(() {
      productOwner = result;
      loading = false;
    });
  }

  scanNFC() async {
    Record valueRed = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
            // NFCReader(title: "NFC page")
            // comment above and uncomment below for testing screen
            NFCMockReader(title: "NFC page")
            ));
    setState(() {
      productOwner = null;
      nfcRecord = valueRed;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      productOwner = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFfbfdfd),
        body: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(children: [
              SizedBox(height: ComponentUtils.screenHeightPercent(context, 2)),
              //I wanted this button little bit smaller but it is retarded and i makes icon smaller fuck
              new SizedBox(
                  width: 40.0,
                  height: 40.0,
                  child: MaterialButton(
                    child: Image.asset(
                      'assets/back_icon_centered.png',
                    ),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: Color(0x77BDBDBD)),
                        borderRadius: BorderRadius.circular(10)),
                    onPressed: () => Navigator.pop(context),
                  )),
              SizedBox(height: ComponentUtils.screenHeightPercent(context, 4)),
              new Text("Check product owner",
                  style: new TextStyle(
                      fontSize: 22.0,
                      fontFamily: 'ProductSans',
                      fontWeight: FontWeight.bold)),
              Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: new Text("Scan product and verify owner's address",
                      style: new TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey,
                        fontFamily: 'ProductSans',
                      ))),
              SizedBox(height: ComponentUtils.screenHeightPercent(context, 10)),
              Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.blueAccent, Color(0xFF84d2f3)]),
                      // color: Color(0xFF84d2f3),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow:
                          ComponentUtils.boxShadow(color: Color(0xAA84d2f3))),
                  height: ComponentUtils.screenHeightPercent(context, 45),
                  width: double.maxFinite,
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 30, 22, 50),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            new Text("Product code:",
                                textAlign: TextAlign.left,
                                style: new TextStyle(
                                  fontSize: 18.0,
                                  color: Color(0xFF515151),
                                  fontFamily: 'ProductSans',
                                )),
                            new Text(
                                nfcRecord != null
                                    ? nfcRecord.productCode
                                    : "No data",
                                textAlign: TextAlign.left,
                                style: new TextStyle(
                                  fontSize: 22.0,
                                  fontFamily: 'ProductSans',
                                )),
                            SizedBox(height: 20),
                            new Text("Manufacturer code:",
                                textAlign: TextAlign.left,
                                style: new TextStyle(
                                  color: Color(0xFF515151),
                                  fontSize: 18.0,
                                  fontFamily: 'ProductSans',
                                )),
                            new Text(
                                nfcRecord != null
                                    ? nfcRecord.manufacturerCode
                                    : "No data",
                                textAlign: TextAlign.left,
                                style: new TextStyle(
                                  fontSize: 22.0,
                                  fontFamily: 'ProductSans',
                                )),
                            SizedBox(
                                height: ComponentUtils.screenHeightPercent(
                                    context, 2)),
                            new Text("Current product owner:",
                                textAlign: TextAlign.left,
                                style: new TextStyle(
                                  fontSize: 20.0,
                                  color: Color(0xFF515151),
                                  fontFamily: 'ProductSans',
                                )),
                            if (loading)
                              Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Center(
                                      child: CircularProgressIndicator()))
                            else
                              new Text(productOwner != null ? productOwner : "",
                                  textAlign: TextAlign.left,
                                  style: new TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: 'ProductSans',
                                  ))
                          ]))),
              Expanded(child: Container()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    height: 80,
                    // minWidth: 200,
                    child: Image.asset(
                      'assets/scan_icon.png',
                      height: 40,
                    ),
                    onPressed: () => scanNFC(),
                    padding: EdgeInsets.all(20.0),
                    color: Color(0xFFfedf85),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  MaterialButton(
                    height: 80,
                    minWidth: 230,
                    child: Text(
                      "CHECK",
                      style: TextStyle(
                        fontSize: 22.0,
                      ),
                    ),
                    onPressed:
                        nfcRecord != null ? () => getTextInputData() : null,
                    padding: EdgeInsets.all(20.0),
                    color: Color(0xFF9ddbf5),
                    disabledColor: Color(0xFFE0E0E0),
                    textColor: Colors.black,
                    disabledTextColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ],
              )
            ], crossAxisAlignment: CrossAxisAlignment.start)));
  }
}
