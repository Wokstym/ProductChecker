import 'package:flutter/material.dart';
import 'package:product_check/src/services/contract_service_impl.dart';
import 'package:product_check/src/services/contract_service_interface.dart';
import 'package:product_check/src/views/ui/nfc_page.dart';

import 'blockchain_requests_page.dart';

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
              child: Text('Go to blockchain requests'),
              onPressed: () {
                navigateToBlockchainPage(context);
              },
            ),
            RaisedButton(
              textColor: Colors.white,
              color: Colors.blue,
              child: Text('Go to NFC page'),
              onPressed: () {
                navigateToNFCPage(context);
              },
            )
          ],
        ),
      ),
    );
  }
}

Future navigateToBlockchainPage(context) async {
  String myAddress = "0xb88Ae3f85603bB13674ae34Be26Fbe1675ff2647";
  String contractAddress = "0x3d890b7D6E34220AAE2DDc9F1979D4ADDaDae9E5";
  String infuraURL =
      "https://kovan.infura.io/v3/c6d67a2b8ed4454283858d137db7593f";
  String contractName = "POMS";
  ContractService contractService = new ContractServiceImpl(
      myAddress, contractAddress, infuraURL, contractName);

  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => BlockchainPage(
                title: "Get Product Owner",
                contractService: contractService,
              )));
}

Future navigateToNFCPage(context) async {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => NFCPage(title: "NFC page")));
}
