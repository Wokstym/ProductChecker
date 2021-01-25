import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:product_check/src/utils/component_utils.dart';

class MainPageRaisedButton extends StatelessWidget {
  final String buttonText;
  final Widget pageToShow;

  const MainPageRaisedButton({this.buttonText, this.pageToShow})
      : assert(pageToShow != null && buttonText != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ComponentUtils.screenWidthPercent(context, 50),
      margin: EdgeInsets.all(10.0),
      child: RaisedButton(
        color: Colors.blue,
        child: new Text(buttonText,
            textAlign: TextAlign.center,
            style: new TextStyle(
                fontSize: 22.0,
                color: Colors.white,
                fontFamily: 'ProductSans',
                fontWeight: FontWeight.bold)),
        elevation: 10.0,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(15.0),
            side: BorderSide(color: Colors.indigo)),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => pageToShow));
        },
      ),
    );
  }
}
