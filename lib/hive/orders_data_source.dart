// import 'dart:developer';

// import 'package:algoretail/hive/generic_hive_controller.dart';
// import 'package:algoretail/models/core/product_history_model.dart';
// import 'package:algoretail/models/core/product_model.dart';
// import 'package:algoretail/models/documents/v2/enums/supplied_status.dart';
// import 'package:algoretail/models/documents/v2/receive_edi_document_model_v2.dart';
// import 'package:algoretail/models/documents/v2/receive_manual_document_model_v2.dart';
// import 'package:hive_flutter/hive_flutter.dart';

// class EdiReceiveStockLocalDatabase implements HiveLocalDataSource {
//   @override
//   Future initialise() async {
//     if (!Hive.isAdapterRegistered(ReceiveEdiDocumentModelV2Adapter().typeId)) {
//       Hive.registerAdapter<ReceiveEdiDocumentModelV2>(
//           ReceiveEdiDocumentModelV2Adapter());
//       Hive.registerAdapter<ProductModel>(ProductModelAdapter());
//       Hive.registerAdapter<ProductHistoryModel>(ProductHistoryModelAdapter());
//       Hive.registerAdapter<ReceiveManualDocumentModelV2>(
//           ReceiveManualDocumentModelV2Adapter());
//       Hive.registerAdapter<SuppliedStatus>(SuppliedStatusAdapter());
//       await Hive.openBox<ReceiveEdiDocumentModelV2>(
//           ReceiveEdiDocumentModelV2.hiveKey);
//       await Hive.openBox<ReceiveManualDocumentModelV2>(
//           ReceiveManualDocumentModelV2.hiveKey);
//       await Hive.openBox<ProductModel>(ProductModel.hiveKey);
//       await Hive.openBox<ProductHistoryModel>(ProductHistoryModel.hiveKey);
//     }
//   }

//   @override
//   Future clearData() async {
//     await GenericHiveController.clearBox<ReceiveEdiDocumentModelV2>(
//         ReceiveEdiDocumentModelV2.hiveKey);
//     await GenericHiveController.clearBox<ReceiveManualDocumentModelV2>(
//         ReceiveManualDocumentModelV2.hiveKey);
//   }

//   @override
//   Future<bool> hasData() async =>
//       await GenericHiveController.hasData<ReceiveEdiDocumentModelV2>(
//           ReceiveEdiDocumentModelV2.hiveKey) ||
//       await GenericHiveController.hasData<ReceiveManualDocumentModelV2>(
//           ReceiveManualDocumentModelV2.hiveKey);

//   Future saveEdiReceive({required ReceiveEdiDocumentModelV2 doc}) async {
//     final box =
//         Hive.box<ReceiveEdiDocumentModelV2>(ReceiveEdiDocumentModelV2.hiveKey);

//     await box.put(doc.ediNum, doc);
//   }

//   Future saveManualReceive({required ReceiveManualDocumentModelV2 doc}) async {
//     if (doc.docId == 0) return;
//     final box = Hive.box<ReceiveManualDocumentModelV2>(
//         ReceiveManualDocumentModelV2.hiveKey);

//     await box.put(doc.docId, doc);
//   }

//   Map<int, ReceiveEdiDocumentModelV2>? getEdiReceives() {
//     final box =
//         Hive.box<ReceiveEdiDocumentModelV2>(ReceiveEdiDocumentModelV2.hiveKey);

//     final documents = box.toMap();

//     if (documents.isNotEmpty) {
//       return Map<int, ReceiveEdiDocumentModelV2>.from(documents);
//     } else {
//       return null;
//     }
//   }

//   Map<int, ReceiveManualDocumentModelV2>? getManualReceives() {
//     final box = Hive.box<ReceiveManualDocumentModelV2>(
//         ReceiveManualDocumentModelV2.hiveKey);

//     final documents = box.toMap();

//     if (documents.isNotEmpty) {
//       return Map<int, ReceiveManualDocumentModelV2>.from(documents);
//     } else {
//       return null;
//     }
//   }

//   void deleteEdiFromBox(int ediNum) {
//     final box =
//         Hive.box<ReceiveEdiDocumentModelV2>(ReceiveEdiDocumentModelV2.hiveKey);

//     box.delete(ediNum);
//   }

//   void deleteManualFromBox(int manualId) {
//     final box = Hive.box<ReceiveManualDocumentModelV2>(
//         ReceiveManualDocumentModelV2.hiveKey);

//     box.delete(manualId);
//   }

//   ReceiveEdiDocumentModelV2? getDocFromDB(int ediNum) {
//     final box =
//         Hive.box<ReceiveEdiDocumentModelV2>(ReceiveEdiDocumentModelV2.hiveKey);

//     return box.get(ediNum);
//   }

//   ReceiveManualDocumentModelV2? getManualDocFromDB(int docId) {
//     final box = Hive.box<ReceiveManualDocumentModelV2>(
//         ReceiveManualDocumentModelV2.hiveKey);

//     return box.get(docId);
//   }
// }
