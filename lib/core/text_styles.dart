import 'package:flutter/material.dart';

const Color textColor = Colors.black;

class AppTextStyle {
  TextStyle get title => const TextStyle(
      fontSize: 24, fontWeight: FontWeight.bold, color: textColor);
  TextStyle get dropDownValues =>
      const TextStyle(fontSize: 12, color: textColor);
  TextStyle get mainListValues =>
      const TextStyle(fontSize: 20, color: textColor);
  TextStyle get cardTitle => const TextStyle(
      fontSize: 20, color: textColor, fontWeight: FontWeight.bold);
}
