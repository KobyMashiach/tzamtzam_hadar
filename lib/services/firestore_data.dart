import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

void firestoreNewDoc(CollectionReference<Map<String, dynamic>> collection,
    {required String docName, Map<String, dynamic>? values}) async {
  collection.doc(docName).set(values ?? {});
}

void firestoreUpdateDoc(CollectionReference<Map<String, dynamic>> collection,
    {required String docName, Map<String, dynamic>? values}) async {
  collection.doc(docName).update(values ?? {});
}

void firestoreClearDoc(CollectionReference<Map<String, dynamic>> collection,
    {required String docName}) async {
  collection.doc(docName).set({});
}

Future<dynamic> firestoreGetDataFromDoc(
    CollectionReference<Map<String, dynamic>> collection,
    String doc,
    String value) async {
  try {
    DocumentSnapshot<Map<String, dynamic>> querySnapshot =
        await collection.doc(doc).get();
    if (querySnapshot.exists) {
      Map<String, dynamic> data = querySnapshot.data()!;
      return data[value];
    }
  } catch (e) {
    log(e.toString());
  }
}

Future<String> uploadImageToStorage(
    {required String path, required XFile imageFile, bool? qrImage}) async {
  String downloadUrl = "";
  final String imageName = qrImage == true ? "qrImage" : "image";
  Reference storageReference =
      FirebaseStorage.instance.ref().child('$path/$imageName');
  UploadTask uploadTask = storageReference.putFile(File(imageFile.path));
  await uploadTask.whenComplete(
      () async => downloadUrl = await storageReference.getDownloadURL());
  return downloadUrl;
}

Future<void> deleteFilesFromFolderOnStorage(String folderPath) async {
  final FirebaseStorage storage = FirebaseStorage.instance;
  final ListResult result = await storage.ref(folderPath).listAll();
  for (final Reference ref in result.items) {
    await ref.delete();
  }
}
// Future<dynamic> getField(
//     {required String companyNum, required String key}) async {
//   try {
//     DocumentSnapshot<Map<String, dynamic>> querySnapshot =
//         await collectionxy.doc(companyNum).get();
//     if (querySnapshot.exists) {
//       Map<String, dynamic> data = querySnapshot.data()!;
//       return await data[key];
//     }
//   } catch (e) {
//     log(e.toString());
//   }
// }

// Future<bool> checkIfDocExists(
//     {required String company,
//     String? managerCode,
//     String? employeePhone}) async {
//   return await checkManagerExist(company, managerCode!);
// }