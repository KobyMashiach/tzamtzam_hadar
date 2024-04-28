import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tzamtzam_hadar/hive/lists_maps_data_source.dart';
import 'package:tzamtzam_hadar/services/firestore_data.dart';
import 'package:tzamtzam_hadar/services/general_lists.dart';

class ListsMapsRepo {
  ListsMapsRepo(this.localDB);
  final collection =
      FirebaseFirestore.instance.collection('all_lists_and_maps');
  final ListsMapsDataSource localDB;

  Future<List<dynamic>> getAllData() async {
    final lastUpdateDB = localDB.getLastUpdate();
    final lastUpdateFS =
        (await firestoreGetDataFromDoc(collection, 'last_update', "lastUpdate"))
            .toDate();
    if (lastUpdateDB == null || !lastUpdateDB.isAtSameMomentAs(lastUpdateFS)) {
      QuerySnapshot querySnapshot = await collection.get();
      final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
      localDB.saveAllData(allData);

      return allData;
    } else {
      return localDB.getAllData();
    }
  }

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
    final imageUrl =
        await uploadImageToStorage(path: "sendFiles/$title", imageFile: image);
    if (qrImage != null)
      qrImageUrl = await uploadImageToStorage(
          path: "sendFiles/$title", imageFile: qrImage, qrImage: true);

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
      docName: 'maps',
      values: {
        "send_files_map": globalSendFiles,
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
    final collection =
        FirebaseFirestore.instance.collection('all_lists_and_maps');
    firestoreUpdateDoc(
      collection,
      docName: 'maps',
      values: {
        "send_files_map": globalSendFiles,
      },
    );
    firestoreUpdateDoc(collection,
        docName: 'last_update',
        values: {"lastUpdate": Timestamp.fromDate(DateTime.now())});
  }
}
