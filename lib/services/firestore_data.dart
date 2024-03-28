import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

var collectionxy = FirebaseFirestore.instance.collection('Companies');

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

void updateFirestoreCompanies(
    {required String company, String? key, dynamic value}) async {
  if (key != null) {
    collectionxy.doc(company).update({
      key: value,
    });
  }
}

void updateFirestoreAddName(
    {required String company, required String value}) async {
  collectionxy.doc(company).update({
    "names": FieldValue.arrayUnion([value]),
  });
}

updateFirestoregetNames({required String company}) async {
  DocumentSnapshot<Map<String, dynamic>> querySnapshot =
      await collectionxy.doc(company).get();
  if (querySnapshot.exists) {
    Map<String, dynamic> data = querySnapshot.data()!["employees"];
    return data.keys.toList();
  }
  return [];
}

Future<String> uploadImageToStorage(
    {required String companyPath, required XFile imageFile}) async {
  String downloadUrl = "";
  Reference storageReference =
      FirebaseStorage.instance.ref().child('$companyPath/logo');
  UploadTask uploadTask = storageReference.putFile(File(imageFile.path));
  await uploadTask.whenComplete(
      () async => downloadUrl = await storageReference.getDownloadURL());
  return downloadUrl;
}

Future<dynamic> getField(
    {required String companyNum, required String key}) async {
  try {
    DocumentSnapshot<Map<String, dynamic>> querySnapshot =
        await collectionxy.doc(companyNum).get();
    if (querySnapshot.exists) {
      Map<String, dynamic> data = querySnapshot.data()!;
      return await data[key];
    }
  } catch (e) {
    log(e.toString());
  }
}

Future<bool> checkIfDocExists(
    {required String company,
    String? managerCode,
    String? employeePhone}) async {
  return await checkManagerExist(company, managerCode!);
}

Future<bool> checkManagerExist(String company, String code) async {
  try {
    DocumentSnapshot<Map<String, dynamic>> doc =
        await collectionxy.doc(company).get();
    final data = doc.data()!["managers"];
    final check = await data[code] != null;
    return await data[code] != null;
  } catch (e) {
    rethrow;
  }
}
