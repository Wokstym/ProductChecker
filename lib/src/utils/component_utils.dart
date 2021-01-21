import 'package:flutter/cupertino.dart';

class ComponentUtils {
  static double screenHeightPercent(BuildContext context, int percent) =>
      (MediaQuery.of(context).size.height / 100 * percent);

  static List<BoxShadow> boxShadow({Color color}) {
    return [
       BoxShadow(
        color: color ?? Color.fromRGBO(0, 0, 0, 0.1),
        blurRadius: 25.0,
        spreadRadius: -5.0,
        offset: Offset(0.0, 20.0),
      ),
      const BoxShadow(
        color: Color.fromRGBO(0, 0, 0, 0.04),
        blurRadius: 10.0,
        spreadRadius: -5.0,
        offset: Offset(0.0, 10.0),
      ),
    ];
  }
}
