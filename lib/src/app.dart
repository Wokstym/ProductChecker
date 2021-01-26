import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  final Widget startPage;

  MyApp(this.startPage);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: startPage,
    );
  }
}
