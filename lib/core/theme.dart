import 'package:flutter/material.dart';
import 'package:tzamtzam_hadar/core/colors.dart';

ThemeData appThemeData() {
  return ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primaryColor),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(AppColor.buttomBackground),
      ),
    ),
    useMaterial3: true,
  );
}
