// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kh_easy_dev/widgets/navigate_page.dart';
import 'package:tzamtzam_hadar/core/colors.dart';
import 'package:tzamtzam_hadar/hive/lists_maps_data_source.dart';
import 'package:tzamtzam_hadar/repos/lists_maps_repo.dart';
import 'package:tzamtzam_hadar/screens/error_page.dart';
import 'package:tzamtzam_hadar/screens/send_files/send_files.dart';
import 'package:tzamtzam_hadar/screens/splash_screen/bloc/splash_screen_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isVisible = false;

  _SplashScreenState() {
    // Timer(const Duration(seconds: 1000), () async {
    //   //TODO: change to 3 or when data load - the big one
    // await checkConnectionNoInternet()
    //     ? KheasydevNavigatePage()
    //           .pushAndRemoveUntil(context, const ErrorPage())
    // : KheasydevNavigatePage()
    //     .pushAndRemoveUntil(context, const SendFiles());
    // });

    Timer(const Duration(milliseconds: 500), () {
      setState(() {
        _isVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => ListsMapsDataSource(),
        ),
        RepositoryProvider(
          create: (context) =>
              ListsMapsRepo(context.read<ListsMapsDataSource>()),
        ),
      ],
      child: BlocProvider(
        create: (context) =>
            SplashScreenBloc(listsMapsRepo: context.read<ListsMapsRepo>())
              ..add(SplashScreenInitialized()),
        child: BlocConsumer<SplashScreenBloc, SplashScreenState>(
          listenWhen: (previous, current) =>
              current is SplashScreenNavigatorState,
          buildWhen: (previous, current) =>
              current is! SplashScreenNavigatorState,
          listener: (context, state) {
            final bloc = context.read<SplashScreenBloc>();
            switch (state.runtimeType) {
              case const (SplashScreenNavigationToNoInternetScreen):
                KheasydevNavigatePage()
                    .pushAndRemoveUntil(context, const ErrorPage());

              case const (SplashScreenNavigationToSendFilesScreen):
                KheasydevNavigatePage()
                    .pushAndRemoveUntil(context, const SendFiles());
            }
          },
          builder: (context, state) {
            final bloc = context.read<SplashScreenBloc>();
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColor.primaryColor, AppColor.shadowColor],
                  begin: const FractionalOffset(0, 0),
                  end: const FractionalOffset(1.0, 1.0),
                  stops: const [0.0, 1.0],
                  tileMode: TileMode.clamp,
                ),
              ),
              child: AnimatedOpacity(
                opacity: _isVisible ? 1.0 : 0,
                duration: const Duration(milliseconds: 2200),
                child: Center(
                  child: Container(
                    height: MediaQuery.sizeOf(context).height,
                    width: MediaQuery.sizeOf(context).width / 1.1,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        // color: const Color.fromARGB(221, 49, 45, 57),
                        color: AppColor.disableColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 2.0,
                            offset: const Offset(5.0, 3.0),
                            spreadRadius: 2.0,
                          )
                        ]),
                    child: Center(
                      child: ClipOval(
                        child: Image.asset("assets/logo.png"),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
