// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tzamtzam_hadar/core/check_first_login.dart';
import 'package:tzamtzam_hadar/core/colors.dart';
import 'package:tzamtzam_hadar/core/translates/delegate.dart';
import 'package:tzamtzam_hadar/firebase_options.dart';
import 'package:tzamtzam_hadar/hive/adapters_controller.dart';
import 'package:tzamtzam_hadar/screens/splash_screen/splash_screen.dart';

class NavigationContextService {
  //TODO: check global key
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDirectory.path);
  //TODO: remove from main and move to a bloc
  AdaptersController.registerAdapters();

  runApp(Phoenix(child: const MyApp()));
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
      navigatorKey: NavigationContextService.navigatorKey,
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
      home: SplashScreen(),
    );
  }
}
