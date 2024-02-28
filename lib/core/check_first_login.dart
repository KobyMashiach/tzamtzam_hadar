import 'dart:developer';
import 'dart:ui';

import 'package:tzamtzam_hadar/core/hive_data.dart';

getLanguage() {
  try {
    return hiveGet(hiveBox: 'local_settings', field: 'language');
  } catch (e) {
    log(name: 'language', 'Don\'t have language');
  }
  return "עברית";
}

Locale getLanguageToLocale() {
  return switch (getLanguage().toString()) {
    "עברית" => const Locale("he", "IR"),
    "English" => const Locale("en", "US"),
    "العربية" => const Locale('ar', 'AR'),
    "русский" => const Locale('ru', 'RU'),
    "français" => const Locale('fr', 'CH'),
    _ => const Locale("he", "IR")
  };
}
