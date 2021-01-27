import 'package:flutter/material.dart';
import 'package:product_check/src/persistance/shared_preferences.dart';
import 'package:product_check/src/services/product_management_interface.dart';
import 'package:product_check/src/services/web3_product_management_service.dart';
import 'package:product_check/src/utils/component_utils.dart';
import 'package:product_check/src/views/ui/contact_methods/receive_product_page.dart';
import 'package:product_check/src/views/ui/contact_methods/ship_product_page.dart';
import 'package:product_check/src/views/ui/save_private_key_page.dart';
import 'package:product_check/src/views/ui/widgets/main_page_button.dart';

import 'contact_methods/get_current_owner_page.dart';
import 'nfc/record_form_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  IProductManagementService productManagementService;
  bool badPrivateKey = false;

  _MainPageState() {
    initService();
  }

  void initService() async {
    String privateKey = await SharedPreferencesHelper.getStringPreference(
        SharedPreferencesHelper.PRIVATE_KEY);

    trySettingServiceWith(privateKey);
  }

  void refreshState() async {
    String privateKey = await SharedPreferencesHelper.getStringPreference(
        SharedPreferencesHelper.PRIVATE_KEY);

    setState(() {
      badPrivateKey = false;
      trySettingServiceWith(privateKey);
    });
  }

  void trySettingServiceWith(String privateKey) {
    try {
      productManagementService = new ProductManagementServiceImpl(
          privateKey,
          "0x3d890b7D6E34220AAE2DDc9F1979D4ADDaDae9E5", // contractAddress
          "https://kovan.infura.io/v3/c6d67a2b8ed4454283858d137db7593f",
          //infuraURL
          "POMS" // contractName
          );
    } catch (e) {
      badPrivateKey = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Builder(
            builder: (innerContext) => Stack(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(32.0, 32.0, 32.0, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                            height:
                                ComponentUtils.screenHeightPercent(context, 2)),
                        Row(
                          children: [
                            SizedBox(
                                width: 40.0,
                                height: 40.0,
                                child: MaterialButton(
                                  child: Image.asset(
                                    'assets/key_icon.png',
                                  ),
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 1, color: Color(0x77BDBDBD)),
                                      borderRadius: BorderRadius.circular(10)),
                                  onPressed: () =>
                                      navigateEditPrivateKeyPage(context),
                                )),
                            Expanded(
                                child: Padding(
                                    padding: const EdgeInsets.only(right: 40.0),
                                    child: Text("Product Checker",
                                        textAlign: TextAlign.center,
                                        style: new TextStyle(
                                          color: Color(0xFF515151),
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'ProductSans',
                                        ))))
                          ],
                        ),
                        SizedBox(
                            height: ComponentUtils.screenHeightPercent(
                                context, 12)),
                        Image.asset(
                          'assets/purple_etherum_logo.png',
                          height:  ComponentUtils.screenHeightPercent(
                            context, 17),
                        ),
                        SizedBox(
                            height: ComponentUtils.screenHeightPercent(
                                context, 12)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MainPageRaisedButton(
                                buttonText: 'Ship Product',
                                isActiveCondition: !badPrivateKey,
                                pageToShow: () =>
                                    ShipProductPage(productManagementService)),
                            MainPageRaisedButton(
                                buttonText: 'Receive Product',
                                isActiveCondition: !badPrivateKey,
                                pageToShow: () => ReceiveProductPage(
                                    productManagementService)),
                          ],
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MainPageRaisedButton(
                                  buttonText: 'Current Owner',
                                  isActiveCondition: !badPrivateKey,
                                  pageToShow: () => CurrentOwnerPage(
                                      productManagementService)),
                              MainPageRaisedButton(
                                buttonText: 'Save data to NFC',
                                pageToShow: () => RecordFormPage(),
                              ),
                            ]),
                        Expanded(child: Container()),
                      ],
                    ),
                  ),
                  if (badPrivateKey)
                    new Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                            decoration: BoxDecoration(
                                color: Color(0xFF323232),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8.0),
                                    topRight: Radius.circular(8.0)),
                                boxShadow: ComponentUtils.boxShadow(
                                    color: Color(0xAA84d2f3))),
                            height: 80,
                            width: double.maxFinite,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                "There seems to be problem with your private key. Please click key icon in top left and insert it again.",
                                style: TextStyle(color: Colors.white),
                              ),
                            )))
                ])));
  }

  void navigateEditPrivateKeyPage(BuildContext context) async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => SavePrivateKeyPage()));
    refreshState();
  }
}
