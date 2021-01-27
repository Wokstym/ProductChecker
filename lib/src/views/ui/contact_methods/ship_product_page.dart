import 'package:flutter/material.dart';
import 'package:product_check/src/models/record.dart';
import 'package:product_check/src/services/base_product_management_service.dart';
import 'package:product_check/src/services/product_management_interface.dart';
import 'package:product_check/src/utils/component_utils.dart';

import '../nfc/nfc_reader.dart';

class ShipProductPage extends StatefulWidget {
  ShipProductPage(this.productManagementService);

  final IProductManagementService productManagementService;

  @override
  _ShipProductPageState createState() =>
      _ShipProductPageState(productManagementService);
}

class _ShipProductPageState extends State<ShipProductPage> {
  final receiverAddressController = TextEditingController();
  final BaseProductManagementService contractService;
  String transactionHash;
  Record nfcRecord;
  bool loading = false;

  _ShipProductPageState(this.contractService);

  processReceiveMethod(BuildContext context) async {
    setState(() {
      loading = true;
    });
    String result = await contractService
        .shipProduct(
            receiverAddressController.text, BigInt.parse(nfcRecord.productCode))
        .timeout(const Duration(seconds: 10), onTimeout: null)
        .catchError((e) {
      Scaffold.of(context).showSnackBar(createErrorSnackBar(e.toString()));
    });

    setState(() {
      transactionHash = result;
      loading = false;
    });
  }

  SnackBar createErrorSnackBar(String errorMessage) {
    return SnackBar(
        content: Text("An error occurred: " + errorMessage),
        duration: Duration(seconds: 3));
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

  String getTextDependsOnResponse() {
    if (transactionHash == null) {
      return "An error occurred while processing your request";
    } else if (transactionHash == "") {
      return transactionHash;
    } else {
      return "You're successfully shipped the product!";
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
  void dispose() {
    super.dispose();
    receiverAddressController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pageTitle = "Ship Product";
    final pageDescription = "Scan product, enter receiver address and ship it!";
    final buttonText = "SHIP";
    return Scaffold(
        backgroundColor: Color(0xFFfbfdfd),
        body: new GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Builder(
                builder: (innerContext) => Padding(
                    padding: const EdgeInsets.fromLTRB(32.0, 32.0, 32.0, 0),
                    child: Column(children: [
                      SizedBox(
                          height:
                              ComponentUtils.screenHeightPercent(context, 2)),
                      new SizedBox(
                          width: 40.0,
                          height: 40.0,
                          child: MaterialButton(
                            child: Image.asset(
                              'assets/back_icon_centered.png',
                            ),
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1, color: Color(0x77BDBDBD)),
                                borderRadius: BorderRadius.circular(10)),
                            onPressed: () => Navigator.pop(context),
                          )),
                      SizedBox(
                          height:
                              ComponentUtils.screenHeightPercent(context, 4)),
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
                      SizedBox(
                          height:
                              ComponentUtils.screenHeightPercent(context, 5)),
                      Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.blueAccent,
                                    Color(0xFF84d2f3)
                                  ]),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: ComponentUtils.boxShadow(
                                  color: Color(0xAA84d2f3))),
                          height:
                              ComponentUtils.screenHeightPercent(context, 50),
                          width: double.maxFinite,
                          child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(30, 25, 22, 25),
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
                                    buildSizedBox(context),
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
                                        height:
                                            ComponentUtils.screenHeightPercent(
                                                context, 10)),
                                    TextFormField(
                                        keyboardType: TextInputType.text,
                                        controller: receiverAddressController,
                                        decoration: InputDecoration(
                                          labelText: "Enter Receiver Address",
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
                                    buildSizedBox(context),
                                    if (loading)
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(top: 20),
                                          child: Center(
                                              child:
                                                  CircularProgressIndicator()))
                                    else
                                      new Text(getTextDependsOnResponse(),
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
                            onPressed: nfcRecord != null
                                ? () => processReceiveMethod(innerContext)
                                : null,
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
                      ),
                      SizedBox(height: 32),
                    ], crossAxisAlignment: CrossAxisAlignment.start)))));
  }

  SizedBox buildSizedBox(BuildContext context) {
    return SizedBox(height: ComponentUtils.screenHeightPercent(context, 3));
  }
}
