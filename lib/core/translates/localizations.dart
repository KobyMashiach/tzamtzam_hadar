import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  Map<String, String> _sentences = {};

  Future<bool> load() async {
    String data =
        await rootBundle.loadString('lang/${locale.languageCode}.json');
    Map<String, dynamic> result = json.decode(data);

    _sentences = <String, String>{};
    result.forEach((String key, dynamic value) {
      _sentences[key] = value.toString();
    });

    return true;
  }

  String trans(
      BuildContext context, String key, Map<String, String>? arguments) {
    if (arguments != null && _sentences[key] != null) {
      String getTranslate = _sentences[key]!;
      for (var arg in arguments.keys) {
        getTranslate = getTranslate.replaceAll("{{$arg}}", arguments[arg]!);
      }

      return getTranslate;
    }
    return _sentences[key] ?? "wrong key";
  }

  Future<void> updateLocale(Locale l) async {
    Get.locale = l;
    await forceAppUpdate();
  }

  Future<void> forceAppUpdate() async {
    await engine.performReassemble();
  }

  WidgetsBinding get engine {
    return WidgetsFlutterBinding.ensureInitialized();
  }
}
