import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tzamtzam_hadar/services/firestore_data.dart';
import 'package:tzamtzam_hadar/services/general_lists.dart';

class SendFilesRepo {
  final collection =
      FirebaseFirestore.instance.collection('all_lists_and_maps');
  final String docName = 'maps';
  final String mapName = 'send_files_map';

  Future<void> uploadNewSendFiles({
    required String title,
    required String description,
    required String type,
    required String networkUrl,
    required XFile image,
    required XFile? qrImage,
    required bool emailLink,
  }) async {
    firestoreUpdateDoc(collection,
        docName: 'last_update',
        values: {"lastUpdate": Timestamp.fromDate(DateTime.now())});
    String qrImageUrl = "";

    final imageUrl = await uploadImageToStorage(
        path: "sendFiles/$title", imageFile: image, imageName: "image");
    if (qrImage != null)
      qrImageUrl = await uploadImageToStorage(
          path: "sendFiles/$title", imageFile: qrImage, imageName: "qrImage");

    globalSendFiles.addAll({
      title: {
        "imageUrl": imageUrl,
        "type": type,
        "description": description,
        "qrCode": qrImageUrl,
        "networkUrl": networkUrl,
        "emailLink": emailLink
      }
    });

    firestoreUpdateDoc(
      collection,
      docName: docName,
      values: {
        mapName: globalSendFiles,
      },
    );

    globalSendFilesTranslated.clear();
    globalSendFilesTranslated.addAll(
      Map<String, dynamic>.fromEntries(
        globalSendFiles.entries
            .map((entry) => MapEntry<String, dynamic>(entry.key, entry.value)),
      ),
    );
  }

  Future<void> removeItemFromSendFiles({required String name}) async {
    await deleteFilesFromFolderOnStorage("sendFiles/${name}");
    globalSendFiles.removeWhere((key, value) => key == name);
    globalSendFilesTranslated.removeWhere((key, value) => key == name);
    firestoreUpdateDoc(
      collection,
      docName: docName,
      values: {
        mapName: globalSendFiles,
      },
    );
    firestoreUpdateDoc(collection,
        docName: 'last_update',
        values: {"lastUpdate": Timestamp.fromDate(DateTime.now())});
  }
}
