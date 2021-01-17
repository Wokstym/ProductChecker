import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:product_check/src/services/contract_service_interface.dart';
import 'package:velocity_x/velocity_x.dart';

class BlockchainPage extends StatefulWidget {
  BlockchainPage({Key key, this.title, this.contractService}) : super(key: key);
  final String title;
  final ContractService contractService;

  @override
  _BlockchainPageState createState() => _BlockchainPageState(contractService);
}

class _BlockchainPageState extends State<BlockchainPage> {
  final String title = "Product Code";
  final productCodeController = TextEditingController();
  final ContractService contractService;
  String productCode = '';
  String productOwner = '';

  _BlockchainPageState(this.contractService);

  getTextInputData() {
    setState(() {
      productCode = productCodeController.text;
      productOwner =
          contractService.getCurrentOwnerAddress(BigInt.parse(productCode));
    });
  }

  @override
  void initState() {
    super.initState();
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
            VStack(
              [
                RaisedButton(
                    onPressed: getTextInputData,
                    color: Colors.blue,
                    shape: Vx.roundedSm,
                    child: "Get Product Owner".text.white.make()),
                5.heightBox,
                Text("Current owner of the product is: $productOwner",
                    style: TextStyle(fontSize: 20))
              ],
              alignment: MainAxisAlignment.spaceAround,
              axisSize: MainAxisSize.max,
            ).p16(),
          ])
        ]));
  }
}
