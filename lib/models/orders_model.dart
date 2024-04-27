// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

part 'orders_model.g.dart';

@HiveType(typeId: 100)
class OrderModel extends HiveObject {
  static const String hiveKey = 'orderModel';

  @HiveField(0)
  final String orderId;
  @HiveField(1)
  final String date;
  @HiveField(2)
  final String time;
  @HiveField(3)
  final String customerName;
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
  @HiveField(10)
  final String? canvasSize;
  @HiveField(11)
  final String? sublimationProduct;
  @HiveField(12)
  final String? employeeName;
  @HiveField(13)
  final int amount;
  @HiveField(14)
  final String status;

  OrderModel(
      {required this.orderId,
      required this.date,
      required this.time,
      required this.customerName,
      required this.phoneNumber,
      required this.category,
      required this.employeeName,
      required this.amount,
      required this.status,
      this.notes,
      this.photoSize,
      this.photoType,
      this.photoFill,
      this.canvasSize,
      this.sublimationProduct});

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'date': date,
      'time': time,
      'customerName': customerName,
      'phoneNumber': phoneNumber,
      "employeeName": employeeName,
      'category': category,
      'notes': notes,
      'photoSize': photoSize,
      'photoType': photoType,
      'photoFill': photoFill,
      "canvasSize": canvasSize,
      "sublimationProduct": sublimationProduct,
      "amount": amount,
      "status": status,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      orderId: map['orderId'] as String? ?? "",
      date: map['date'] as String? ?? "",
      time: map['time'] as String? ?? "",
      customerName: map['customerName'] as String? ?? "",
      phoneNumber: map['phoneNumber'] as String? ?? "",
      employeeName: map['employeeName'] as String? ?? "",
      category: map['category'] as String? ?? "",
      notes: map['notes'] as String? ?? "",
      photoSize: map['photoSize'] as String? ?? "",
      photoType: map['photoType'] as String? ?? "",
      photoFill: map['photoFill'] as String? ?? "",
      canvasSize: map['canvasSize'] as String? ?? "",
      sublimationProduct: map['photoFsublimationProductill'] as String? ?? "",
      amount: map['amount'] as int,
      status: map['status'] as String,
    );
  }

  @override
  String toString() {
    return 'OrderModel(orderId: $orderId, date: $date, time: $time, customerName: $customerName, phoneNumber: $phoneNumber, category: $category, notes: $notes, photoSize: $photoSize, photoType: $photoType, photoFill: $photoFill, canvasSize: $canvasSize, sublimationProduct: $sublimationProduct, employeeName: $employeeName, amount: $amount, status: $status)';
  }
}
