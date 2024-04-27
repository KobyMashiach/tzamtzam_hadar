import 'package:connectivity_plus/connectivity_plus.dart';

checkConnection() async => await (Connectivity().checkConnectivity());
checkConnectionMobile() async =>
    await (Connectivity().checkConnectivity()) == ConnectivityResult.mobile;

checkConnectionWifi() async =>
    await (Connectivity().checkConnectivity()) == ConnectivityResult.wifi;

Future<bool> checkConnectionNoInternet() async {
  final connectivityResult = await Connectivity().checkConnectivity();

  return connectivityResult.first != ConnectivityResult.wifi &&
      connectivityResult.first != ConnectivityResult.mobile;
}
