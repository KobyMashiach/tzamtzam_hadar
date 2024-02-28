// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:kh_easy_dev/kh_easy_dev.dart';
import 'package:kh_easy_dev/widgets/navigate_page.dart';
import 'package:tzamtzam_hadar/core/colors.dart';
import 'package:tzamtzam_hadar/core/translates/get_tran.dart';
import 'package:tzamtzam_hadar/screens/home/home_page.dart';
import 'package:tzamtzam_hadar/widgets/general/appbar.dart';

appSideMenu(BuildContext context, {required int index}) {
  return KheasydevSideMenu(
    selectedIndex: index,
    shadowColor: AppColor.primaryColor,
    disableColor: AppColor.disableColor,
    // appName: 'Iron Post',
    sidebarItems: [
      SideBarModel(
          icon: Icons.grid_view_outlined,
          label: appTranslate(context, "home_screen"),
          onTap: () {
            KheasydevNavigatePage().pushAndRemoveUntil(context, HomePage());
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
