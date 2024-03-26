import 'package:flutter/material.dart';
import 'package:kh_easy_dev/kh_easy_dev.dart';
import 'package:tzamtzam_hadar/core/colors.dart';

appAppBar(
    {required String title,
    List<Widget>? actions,
    Widget? developerPage,
    VoidCallback? onBackButtonPreesed,
    BuildContext? context}) {
  return kheasydevAppBar(
      title: title,
      logoPath: 'assets/logo.png',
      primaryColor: AppColor.primaryColor,
      shadowColor: AppColor.shadowColor,
      titleColor: Colors.black,
      actions: actions,
      developerPage: developerPage,
      leading: onBackButtonPreesed != null
          ? IconButton(
              onPressed: onBackButtonPreesed, icon: Icon(Icons.arrow_back))
          : null,
      context: context);
}
