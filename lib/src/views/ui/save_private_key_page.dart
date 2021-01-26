import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:product_check/src/persistance/shared_preferences.dart';
import 'package:product_check/src/utils/component_utils.dart';
import 'package:product_check/src/views/ui/main_page.dart';

class SavePrivateKeyPage extends StatelessWidget {
  final privateKeyController = TextEditingController();

  void savePreferenceAndProceedToNextScreen(BuildContext context) async {
    String current = await SharedPreferencesHelper.getStringPreference(
        SharedPreferencesHelper.PRIVATE_KEY);

    await SharedPreferencesHelper.saveStringPreference(
        SharedPreferencesHelper.PRIVATE_KEY, privateKeyController.text);

    if (current != null)
      Navigator.pop(context);
    else
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainPage()));
  }

  @override
  Widget build(BuildContext context) {
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
                              ComponentUtils.screenHeightPercent(context, 20)),
                      Text("Welcome to Product checker                ",
                          textAlign: TextAlign.left,
                          style: new TextStyle(
                              fontSize: 22.0,
                              fontFamily: 'ProductSans',
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      new Text(
                          "App designed to secure supply chain and prevent counterfeiting",
                          style: new TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey,
                            fontFamily: 'ProductSans',
                          )),
                      SizedBox(
                          height:
                              ComponentUtils.screenHeightPercent(context, 20)),
                      TextFormField(
                          keyboardType: TextInputType.text,
                          controller: privateKeyController,
                          decoration: InputDecoration(
                            labelText: "Enter your private key",
                            fillColor: Colors.white,
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                              borderSide: new BorderSide(),
                            ),
                          )),
                      SizedBox(
                          height:
                              ComponentUtils.screenHeightPercent(context, 5)),
                      MaterialButton(
                        height: 80,
                        minWidth: 230,
                        child: Text(
                          "Save and proceed",
                          style: TextStyle(
                            fontSize: 22.0,
                          ),
                        ),
                        onPressed: privateKeyController.text != ""
                            ? () =>
                                savePreferenceAndProceedToNextScreen(context)
                            : null,
                        padding: EdgeInsets.all(20.0),
                        color: Colors.blue,
                        disabledColor: Color(0xFFE0E0E0),
                        textColor: Colors.white,
                        disabledTextColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                    ])))));
  }
}
