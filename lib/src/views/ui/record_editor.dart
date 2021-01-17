import 'package:flutter/material.dart';
import 'package:product_check/src/models/record.dart';

class RecordEditor {
  TextEditingController productCode;
  TextEditingController manufacturerCode;

  RecordEditor() {
    productCode = TextEditingController();
    manufacturerCode = TextEditingController();
  }

  bool areBothFieldsFilled() {
    return manufacturerCode.text != "" && productCode.text != "";
  }

  Record getRecord() {
    return new Record(productCode.text, manufacturerCode.text);
  }
}