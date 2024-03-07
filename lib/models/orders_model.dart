// extends HiveObject
import 'package:hive/hive.dart';

// part 'orders_model.g.dart';

@HiveType(typeId: 100)
class Order {
  static const String hiveKey = 'orderModel';

  @HiveField(0)
  final String orderId;
  @HiveField(1)
  final String date;
  @HiveField(2)
  final String time;
  @HiveField(3)
  final String fullName;
  @HiveField(4)
  final String phoneNumber;
  @HiveField(5)
  final String category;
  @HiveField(6)
  final String? notes;
  @HiveField(7)
  final String? photoSize;
  @HiveField(8)
  final String? photoType;
  @HiveField(9)
  final String? photoFill;

  Order({
    required this.orderId,
    required this.date,
    required this.time,
    required this.fullName,
    required this.phoneNumber,
    required this.category,
    this.notes,
    this.photoSize,
    this.photoType,
    this.photoFill,
  });

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'date': date,
      'time': time,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'category': category,
      'notes': notes,
      'photoSize': photoSize,
      'photoType': photoType,
      'photoFill': photoFill,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      orderId: map['orderId'] as String? ?? "",
      date: map['date'] as String? ?? "",
      time: map['time'] as String? ?? "",
      fullName: map['fullName'] as String? ?? "",
      phoneNumber: map['phoneNumber'] as String? ?? "",
      category: map['category'] as String? ?? "",
      notes: map['notes'] as String? ?? "",
      photoSize: map['photoSize'] as String? ?? "",
      photoType: map['photoType'] as String? ?? "",
      photoFill: map['photoFill'] as String? ?? "",
    );
  }
}
