import 'package:flutter/material.dart';
import 'package:product_check/src/models/record.dart';
import 'package:product_check/src/services/product_management_interface.dart';
import 'package:product_check/src/services/web3_product_management_service.dart';
import 'package:product_check/src/views/ui/contact_methods/receive_product_page.dart';
import 'package:product_check/src/views/ui/contact_methods/ship_product_page.dart';
import 'package:product_check/src/views/ui/nfc_reader.dart';
import 'package:product_check/src/views/ui/nfc_writer.dart';
import 'package:product_check/src/views/ui/widgets/main_page_button.dart';

import 'contact_methods/get_current_owner_page.dart';

class MainPage extends StatelessWidget {
  final IProductManagementService productManagementService =
      new ProductManagementServiceImpl(
          "615a8c90655ba5ad2774e5597e7e8882ccf124fb9cf5a09f8f2b2ca570fd3c93",
          //privateKey
          "0x3d890b7D6E34220AAE2DDc9F1979D4ADDaDae9E5", // contractAddress
          "https://kovan.infura.io/v3/c6d67a2b8ed4454283858d137db7593f", //infuraURL
          "POMS" // contractName
          );

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
            MainPageRaisedButton(
                buttonText: 'Ship Product',
                pageToShow: ShipProductPage(productManagementService)),
            MainPageRaisedButton(
                buttonText: 'Receive Product',
                pageToShow: ReceiveProductPage(productManagementService)),
            MainPageRaisedButton(
                buttonText: 'Current Owner',
                pageToShow: CurrentOwnerPage(productManagementService)),
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

Future navigateToReadNFCPage(context) async {
  Record result = await Navigator.push(context,
      MaterialPageRoute(builder: (context) => NFCReader(title: "NFC page")));

  if (result == null)
    print("Nothing scanned");
  else {
    print(result.toString());
  }
}

Future navigateToWriteNFCPage(context) async {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => NFCWriter(
                title: "NFC page",
                record: Record("212321", "22342643622"),
              )));
}
