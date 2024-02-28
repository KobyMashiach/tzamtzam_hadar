import 'package:flutter/material.dart';
import 'package:tzamtzam_hadar/core/translates/localizations.dart';

String appTranslate(BuildContext context, String key,
    {Map<String, String>? arguments}) {
  return AppLocalizations.of(context)?.trans(context, key, arguments) ??
      "wrong key";
}
