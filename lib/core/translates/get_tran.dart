import 'package:tzamtzam_hadar/core/translates/localizations.dart';
import 'package:tzamtzam_hadar/main.dart';

String appTranslate(String key, {Map<String, String>? arguments}) {
  final context = NavigationContextService.navigatorKey.currentContext;
  return AppLocalizations.of(context!)?.trans(context, key, arguments) ??
      "wrong key";
}
