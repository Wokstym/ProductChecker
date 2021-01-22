import 'package:flutter/material.dart';
import 'package:product_check/src/services/base_product_management_service.dart';
import 'package:product_check/src/services/product_management_interface.dart';

class ShipProductPage extends StatefulWidget {
  ShipProductPage(this.productManagementService);

  final IProductManagementService productManagementService;

  @override
  _ShipProductState createState() =>
      _ShipProductState(productManagementService);
}

class _ShipProductState extends State<ShipProductPage> {
  final BaseProductManagementService contractService;

  _ShipProductState(this.contractService);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFfbfdfd),
      body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              RaisedButton(
                textColor: Colors.white,
                color: Colors.blue,
                child: Text('Ship product'),
                onPressed: () {
                  contractService.shipProduct(
                      "0xa64E0ecECc8fb8BA0cF09c51534042f09B436CB5",
                      BigInt.from(212321));
                },
              ),
            ],
          )),
    );
  }
}
