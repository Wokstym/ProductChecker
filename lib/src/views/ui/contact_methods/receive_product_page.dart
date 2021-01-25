import 'package:flutter/material.dart';
import 'package:product_check/src/models/record.dart';
import 'package:product_check/src/services/base_product_management_service.dart';
import 'package:product_check/src/services/product_management_interface.dart';
import 'package:product_check/src/utils/component_utils.dart';
import 'package:product_check/src/views/ui/nfc_reader.dart';

class ReceiveProductPage extends StatefulWidget {
  ReceiveProductPage(this.productManagementService);

  final IProductManagementService productManagementService;

  @override
  _ReceiveProductPageState createState() =>
      _ReceiveProductPageState(productManagementService);
}

class _ReceiveProductPageState extends State<ReceiveProductPage> {
  final BaseProductManagementService contractService;
  String transactionHash;
  Record nfcRecord;
  bool loading = false;

  _ReceiveProductPageState(this.contractService);

  processReceiveMethod() async {
    setState(() {
      loading = true;
    });
    String result = await contractService
        .receiveProduct(BigInt.parse(nfcRecord.productCode));
    setState(() {
      transactionHash = result;
      loading = false;
    });
  }

  scanNFC() async {
    Record valueRed = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NFCReader(title: "NFC page")
            // comment above and uncomment below for testing screen
            // NFCMockReader(title: "NFC page")
            ));
    setState(() {
      transactionHash = "";
      nfcRecord = valueRed;
    });
  }

  String getTextDependsOnRequest() {
    if (transactionHash == null) {
      return "An error occurred while processing your request";
    } else if (transactionHash == "") {
      return transactionHash;
    } else {
      return "Congratulation! You're the owner now!";
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      transactionHash = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    final pageTitle = "Receive Product";
    final pageDescription = "Scan product to become the owner!";
    final buttonText = "RECEIVE";
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
              new Text(pageTitle,
                  style: new TextStyle(
                      fontSize: 22.0,
                      fontFamily: 'ProductSans',
                      fontWeight: FontWeight.bold)),
              Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: new Text(pageDescription,
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
                  height: ComponentUtils.screenHeightPercent(context, 40),
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
                            if (loading)
                              Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Center(
                                      child: CircularProgressIndicator()))
                            else
                              new Text(getTextDependsOnRequest(),
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
                      buttonText,
                      style: TextStyle(
                        fontSize: 22.0,
                      ),
                    ),
                    onPressed:
                        nfcRecord != null ? () => processReceiveMethod() : null,
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
