import 'package:url_launcher/url_launcher.dart';

class GeneralFunctions {
  formatOrderId(int orderId) => orderId.toString().padLeft(4, '0');
  openWeb(String url) async =>
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
}
