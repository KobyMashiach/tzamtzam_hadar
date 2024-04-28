import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';
import 'dart:io';

class GeneralFunctions {
  formatOrderId(int orderId) => orderId.toString().padLeft(4, '0');

  openWeb(String url) async {
    String openUrl;
    if (!url.startsWith('mailto:') &&
        !url.startsWith("tel:") &&
        !url.startsWith('https://') &&
        !url.startsWith('http://')) {
      openUrl = 'https://$url';
    } else {
      openUrl = url;
    }
    await launchUrl(Uri.parse(openUrl), mode: LaunchMode.externalApplication);
  }

  Future<XFile?> chooseImage(ImageSource source) async {
    await checkPermission();
    final ImagePicker picker = ImagePicker();
    final XFile? image =
        await picker.pickImage(source: source, imageQuality: 30);
    return image;
  }

  Future<XFile> getImageFileFromUrl(String imageUrl) async {
    http.Response response = await http.get(Uri.parse(imageUrl));
    Uint8List bytes = response.bodyBytes;

    final tempDir = await getTemporaryDirectory();
    File file = File(
        '${tempDir.path}/${imageUrl.substring(imageUrl.length - 10, imageUrl.length)}.jpg');
    await file.writeAsBytes(bytes);
    return XFile(file.path);
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
