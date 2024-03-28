import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tzamtzam_hadar/core/app_data.dart';
import 'package:tzamtzam_hadar/core/check_first_login.dart';
import 'package:tzamtzam_hadar/core/hive_data.dart';
import 'package:tzamtzam_hadar/core/translates/get_tran.dart';

String selectedLanguage = getLanguage() is String ? getLanguage() : "עברית";
// String selectedLanguage = "עברית";

Container languagePicker(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      border: Border.all(
        color: Colors.black,
        width: 2,
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: DropdownButton(
        value: selectedLanguage,
        style: Theme.of(context).textTheme.titleLarge,
        underline: Container(),
        onChanged: (String? newValue) {
          selectedLanguage = newValue!;
          getupdateLocale(selectedLanguage);
          hiveSave(
              hiveBox: 'local_settings',
              field: 'language',
              key: selectedLanguage);
        },
        items: [
          dropdownItem(context, language: "hebrew", flag: FlagIcons.il),
          dropdownItem(context, language: "english", flag: FlagIcons.usa),
          dropdownItem(context, language: "arabic", flag: FlagIcons.arabic),
          dropdownItem(context, language: "france", flag: FlagIcons.france),
          dropdownItem(context, language: "russian", flag: FlagIcons.russia),
        ],
      ),
    ),
  );
}

void getupdateLocale(String selectedLanguage) {
  switch (selectedLanguage) {
    case "עברית":
      Get.updateLocale(const Locale('he'));
      break;
    case "English":
      Get.updateLocale(const Locale('en'));
      break;
    case "العربية":
      Get.updateLocale(const Locale('ar'));
      break;

    case "русский":
      Get.updateLocale(const Locale('ru'));
      break;
    case "français":
      Get.updateLocale(const Locale('fr'));
      break;
  }
}

DropdownMenuItem<String> dropdownItem(BuildContext context,
    {required String language, required String flag}) {
  return DropdownMenuItem(
    value: appTranslate(language),
    child: Row(
      children: [
        SvgPicture.asset(
          flag,
          width: 30,
        ),
        const SizedBox(width: 8),
        Text(appTranslate(language)),
      ],
    ),
  );
}
