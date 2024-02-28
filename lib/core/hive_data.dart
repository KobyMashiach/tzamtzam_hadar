import 'package:hive_flutter/hive_flutter.dart';

void hiveSave(
    {required String hiveBox, required String field, required dynamic key}) {
  final box = Hive.box(hiveBox);
  box.put(field, key);
}

dynamic hiveGet({required String hiveBox, required String field}) {
  final box = Hive.box(hiveBox);
  final dynamic value = box.get(field);
  return value;
}

void hiveClearBox({required String hiveBox}) {
  final box = Hive.box(hiveBox);
  box.clear();
}

// bool hiveAllFirstRegisterBoxTrue() {
//   const int numOfFields = 4;
//   int checkFields = 0;
//   // Use reflection to get all fields
//   final box = Hive.box('first_register');
//   final fields = box.values;
//   for (var field in fields) {
//     if (field is bool && !field) {
//       return false;
//     }
//     if (field is bool) checkFields++;
//   }
//   if (checkFields != numOfFields) return false;
//   return true;
// }
