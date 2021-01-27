import 'package:flutter/material.dart';
import 'package:product_check/src/app.dart';
import 'package:product_check/src/persistance/shared_preferences.dart';
import 'package:product_check/src/views/ui/main_page.dart';
import 'package:product_check/src/views/ui/save_private_key_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String privateKey = await SharedPreferencesHelper.getStringPreference(
      SharedPreferencesHelper.PRIVATE_KEY);

  Widget startPage = privateKey == null ? SavePrivateKeyPage() : MainPage();
  runApp(MyApp(startPage));
}
