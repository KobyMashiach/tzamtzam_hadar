import 'package:hive_flutter/hive_flutter.dart';

part 'contact_model.g.dart';

@HiveType(typeId: 102)
class ContactModel extends HiveObject {
  static const String hiveKey = 'contactsModel';

  @HiveField(1)
  final String name;
  @HiveField(2)
  final String phoneNumber;

  ContactModel({
    required this.name,
    required this.phoneNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
    };
  }

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      name: map['name'] as String? ?? "",
      phoneNumber: map['phoneNumber'] as String? ?? "",
    );
  }

  @override
  String toString() => 'ContactModel(name: $name, phoneNumber: $phoneNumber)';
}
