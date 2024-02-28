import 'package:flutter/material.dart';
import 'package:kh_easy_dev/kh_easy_dev.dart';
import 'package:tzamtzam_hadar/core/colors.dart';

appAppBar(
    {required String title,
    List<Widget>? actions,
    Widget? developerPage,
    BuildContext? context}) {
  return kheasydevAppBar(
      title: title,
      logoPath: 'assets/logo.png',
      primaryColor: AppColor.primaryColor,
      shadowColor: AppColor.shadowColor,
      actions: actions,
      developerPage: developerPage,
      // titleColor: Colors.black,
      context: context);
}
