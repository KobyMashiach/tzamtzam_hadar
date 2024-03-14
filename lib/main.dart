import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tzamtzam_hadar/core/check_first_login.dart';
import 'package:tzamtzam_hadar/core/colors.dart';
import 'package:tzamtzam_hadar/core/theme.dart';
import 'package:tzamtzam_hadar/core/translates/delegate.dart';
import 'package:tzamtzam_hadar/hive/adapters_controller.dart';
import 'package:tzamtzam_hadar/hive/orders_data_source.dart';
import 'package:tzamtzam_hadar/screens/home/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDirectory.path);
  AdaptersController.registerAdapters();
  await OrdersDataSource.initialise();

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
