import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String PRIVATE_KEY = "private_key";

  static Future<void> saveStringPreference(String name, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString(name, value);
  }

  static Future<String> getStringPreference(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(name);
  }
}
