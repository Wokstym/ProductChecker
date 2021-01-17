import 'package:flutter/material.dart';
import 'package:product_check/src/views/ui/nfc_page.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: NFCPage(title: 'NFC Scan'),
    );
  }
}
