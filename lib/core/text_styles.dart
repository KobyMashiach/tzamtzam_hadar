import 'package:flutter/material.dart';

final Color textColor = Colors.black;

class AppTextStyle {
  TextStyle get title =>
      TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: textColor);
  TextStyle get dropDownValues => TextStyle(fontSize: 12, color: textColor);
  TextStyle get mainListValues => TextStyle(fontSize: 20, color: textColor);
  TextStyle get cardTitle =>
      TextStyle(fontSize: 20, color: textColor, fontWeight: FontWeight.bold);
}
