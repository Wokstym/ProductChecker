import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:web3dart/web3dart.dart';

class BlockchainPage extends StatefulWidget {
  BlockchainPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _BlockchainPageState createState() => _BlockchainPageState();
}

class _BlockchainPageState extends State<BlockchainPage> {
  final String title = "Product Code";
  final String myAddress = "0xb88Ae3f85603bB13674ae34Be26Fbe1675ff2647";
  final String infuraURL = "https://kovan.infura.io/v3/c6d67a2b8ed4454283858d137db7593f";
  Client httpClient;
  Web3Client ethClient;
  final productCodeController = TextEditingController();
  String productCode = '';

  getTextInputData() {
    setState(() {
      productCode = productCodeController.text;
      // getProductOwner(productCode);
      print(productCode);
    });
  }

  @override
  void initState() {
    super.initState();
    httpClient = Client();
    ethClient = Web3Client(infuraURL, httpClient);
  }

  @override
  void dispose() {
    productCodeController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ZStack([
          VxBox()
              .blue600
              .size(context.screenWidth, context.percentHeight * 30)
              .make(),
          VStack([
            (context.percentHeight * 10).heightBox,
            "\Get Product Owner"
                .text
                .xl4
                .white
                .bold
                .center
                .makeCentered()
                .py16(),
            (context.percentHeight * 5).heightBox,
            VxBox(
                child: VStack([
                  title.text.gray700.xl2.semiBold.makeCentered(),
                  10.heightBox,
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: productCodeController,
                    decoration: InputDecoration(
                      hintText: "ENTER " + title.toUpperCase(),
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(),
                      ),
                    ),
                  ),
                ]))
                .p16
                .white
                .size(context.screenWidth, context.percentHeight * 20)
                .rounded
                .shadowXl
                .make()
                .p16(),
            5.heightBox,
            HStack([
              RaisedButton(
                  onPressed: getTextInputData,
                  color: Colors.blue,
                  shape: Vx.roundedSm,
                  child: "Get Product Owner".text.white.make())
            ],
              alignment: MainAxisAlignment.spaceAround,
              axisSize: MainAxisSize.max,
            ).p16()
          ])
        ]));
  }
}
