import 'package:flutter/material.dart';
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
  Navigator.push(context, MaterialPageRoute(builder: (context) => BlockchainPage(title: "Get Product Owner")));
}

Future navigateToNFCPage(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => NFCPage(title: "NFC page")));
}