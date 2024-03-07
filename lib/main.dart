import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:tzamtzam_hadar/core/check_first_login.dart';
import 'package:tzamtzam_hadar/core/colors.dart';
import 'package:tzamtzam_hadar/core/theme.dart';
import 'package:tzamtzam_hadar/core/translates/delegate.dart';
import 'package:tzamtzam_hadar/screens/home/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ErrorWidget.builder = (FlutterErrorDetails) => SingleChildScrollView(
    //       child: Container(
    //         color: AppColor.primaryColor,
    //         child: Text(FlutterErrorDetails.toString(),
    //             textDirection: TextDirection.ltr),
    //       ),
    //     );
    return GetMaterialApp(
      localizationsDelegates: const [
        AppLocalizationsDelegate(),
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("he", "IR"), // Hebrew
        Locale("en", "US"), // English
        Locale('ar', 'AE'), // Arabic
        Locale('fr', 'FR'), // France
        Locale('ru', 'RU'), // Russian
      ],
      localeResolutionCallback:
          (Locale? locale, Iterable<Locale> supportedLocales) {
        if (locale == null) return null;
        for (Locale supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode) {
            return supportedLocale;
          }
        }
        return null;
      },
      debugShowCheckedModeBanner: false,
      locale: getLanguageToLocale(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primaryColor),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
