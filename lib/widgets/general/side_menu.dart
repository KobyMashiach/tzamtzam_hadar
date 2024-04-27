// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kh_easy_dev/kh_easy_dev.dart';
import 'package:kh_easy_dev/widgets/navigate_page.dart';
import 'package:tzamtzam_hadar/core/colors.dart';
import 'package:tzamtzam_hadar/core/translates/get_tran.dart';
import 'package:tzamtzam_hadar/hive/general_data_source.dart';
import 'package:tzamtzam_hadar/screens/managment/managment.dart';
import 'package:tzamtzam_hadar/screens/orders_managment/order_managment_root.dart';
import 'package:tzamtzam_hadar/screens/send_files/send_files.dart';
import 'package:tzamtzam_hadar/widgets/general/appbar.dart';

appSideMenu(BuildContext context, {required int index}) {
  final permission = GeneralDataSource.getPermissions();
  //TODO: add to splash screen function that prints all logs
  //TODO: on splash screen load all images
  log(name: "permission", permission.toString());
  return KheasydevSideMenu(
    selectedIndex: index,
    shadowColor: AppColor.primaryColor,
    disableColor: AppColor.disableColor,
    // appName: 'Iron Post',
    sidebarItems: [
      SideBarModel(
          icon: Icons.file_copy_outlined,
          label: appTranslate("send_files"),
          onTap: () {
            KheasydevNavigatePage().pushAndRemoveUntil(context, SendFiles());
          }),
      if (permission.toId() <= 3) // no customer
        SideBarModel(
            icon: Icons.manage_accounts_outlined,
            label: appTranslate("orders_managment"),
            onTap: () {
              KheasydevNavigatePage()
                  .pushAndRemoveUntil(context, OrderManagmentRoot());
            }),
      if (permission.toId() <= 2)
        SideBarModel(
            icon: Icons.settings_applications_outlined,
            label: appTranslate("managment"),
            onTap: () {
              KheasydevNavigatePage().pushAndRemoveUntil(context, Managment());
            }),
    ],
    buttomBackground: AppColor.buttomBackground,
    appBar: appAppBar(title: 'יצירת קשר'),
    contactUsScreen: Scaffold(
      appBar: appAppBar(title: 'יצירת קשר'),
      body: const ContactUs(
        textColor: AppColor.buttomBackground,
        logo: AssetImage('assets/logo.png'),
        email: 'hadar@tzamtzam.com',
        companyName: 'צמצם קניון הדר',
        phoneNumber: '02-6739911',
        website: 'https://www.tzamtzam.co.il',
        // instagram: 'gifture_il',
        // facebookHandle: 'GIFTUREIL',
        // tiktokUrl: "gifture_il",
      ),
    ),
  );
}
