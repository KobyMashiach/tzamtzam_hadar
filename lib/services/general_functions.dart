import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';

class GeneralFunctions {
  formatOrderId(int orderId) => orderId.toString().padLeft(4, '0');
  openWeb(String url) async =>
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);

  Future<XFile?> chooseImage(ImageSource source) async {
    await checkPermission();
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    return image;
  }
}

Future<void> checkPermission() async {
  Map<Permission, PermissionStatus> statues =
      await [Permission.storage, Permission.photos].request();
  PermissionStatus? statusStorage = statues[Permission.storage];
  PermissionStatus? statusPhotos = statues[Permission.photos];
  bool isGranted = statusStorage == PermissionStatus.granted &&
      statusPhotos == PermissionStatus.granted;
  if (isGranted) {}
  bool isPermanentlyDenied =
      statusStorage == PermissionStatus.permanentlyDenied ||
          statusPhotos == PermissionStatus.permanentlyDenied;
  if (isPermanentlyDenied) {}
}
