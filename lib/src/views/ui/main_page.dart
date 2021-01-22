import 'package:flutter/material.dart';
import 'package:product_check/src/models/record.dart';
import 'package:product_check/src/services/web3_product_management_service.dart';
import 'package:product_check/src/services/base_product_management_service.dart';
import 'package:product_check/src/views/ui/contact_methods/ship_product_page.dart';
import 'package:product_check/src/views/ui/nfc_reader.dart';
import 'package:product_check/src/views/ui/nfc_writer.dart';

import 'contact_methods/get_current_owner_page.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              textColor: Colors.white,
              color: Colors.blue,
              child: Text('Ship Product'),
              onPressed: () {
                navigateToShipProduct(context);
              },
            ),
            RaisedButton(
              textColor: Colors.white,
              color: Colors.blue,
              child: Text('Get Current Owner'),
              onPressed: () {
                navigateToCurrentOwnerPage(context);
              },
            ),
            RaisedButton(
              textColor: Colors.white,
              color: Colors.blue,
              child: Text('Go to Read NFC page'),
              onPressed: () {
                navigateToReadNFCPage(context);
              },
            ),
            RaisedButton(
              textColor: Colors.white,
              color: Colors.blue,
              child: Text('Go to write NFC page'),
              onPressed: () {
                navigateToWriteNFCPage(context);
              },
            )
          ],
        ),
      ),
    );
  }
}

Future navigateToCurrentOwnerPage(context) async {
  // String myAddress = "0xb88Ae3f85603bB13674ae34Be26Fbe1675ff2647";
  String privateKey = "615a8c90655ba5ad2774e5597e7e8882ccf124fb9cf5a09f8f2b2ca570fd3c93";
  String contractAddress = "0x3d890b7D6E34220AAE2DDc9F1979D4ADDaDae9E5";
  String infuraURL =
      "https://kovan.infura.io/v3/c6d67a2b8ed4454283858d137db7593f";
  String contractName = "POMS";
  BaseProductManagementService productManagementService =
  new ProductManagementServiceImpl(privateKey,
      contractAddress, infuraURL, contractName);

  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              CurrentOwnerPage(
                title: "Get Product Owner",
                productManagementService: productManagementService,
              )));
}

Future navigateToShipProduct(context) async {
  String privateKey = "615a8c90655ba5ad2774e5597e7e8882ccf124fb9cf5a09f8f2b2ca570fd3c93";
  String contractAddress = "0x3d890b7D6E34220AAE2DDc9F1979D4ADDaDae9E5";
  String infuraURL =
      "https://kovan.infura.io/v3/c6d67a2b8ed4454283858d137db7593f";
  String contractName = "POMS";
  BaseProductManagementService productManagementService =
  new ProductManagementServiceImpl(privateKey,
      contractAddress, infuraURL, contractName);
  Navigator.push(context,
      MaterialPageRoute(
          builder: (context) => ShipProductPage(productManagementService)));
}

Future navigateToReadNFCPage(context) async {
  Record result = await Navigator.push(context,
      MaterialPageRoute(builder: (context) => NFCReader(title: "NFC page")));

  if (result == null)
    print("Nothing scanned");
  else {
    print(result.toString());
  }
}

Future navigateToWriteNFCPage(BuildContext context) async {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              NFCWriter(
                title: "NFC page",
                record: Record("212321", "22342643622"),
              )));
}
