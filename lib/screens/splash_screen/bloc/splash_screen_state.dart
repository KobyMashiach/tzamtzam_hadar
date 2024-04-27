part of 'splash_screen_bloc.dart';

@immutable
abstract class SplashScreenState {}

class SplashScreenInitial extends SplashScreenState {}

@immutable
abstract class SplashScreenNavigatorState extends SplashScreenState {}

class SplashScreenNavigationToNoInternetScreen
    extends SplashScreenNavigatorState {}

class SplashScreenNavigationToSendFilesScreen
    extends SplashScreenNavigatorState {
  final List<dynamic> allData;

  SplashScreenNavigationToSendFilesScreen({required this.allData});
}
