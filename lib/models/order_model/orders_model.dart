import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:tzamtzam_hadar/models/order_in_model/order_in_model.dart';

part 'orders_model.freezed.dart';
part 'orders_model.g.dart';

//extends HiveObject
// @HiveType(typeId: 100)

@freezed
class OrderModel with _$OrderModel {
  static const String hiveKey = 'orderModel';
  @HiveType(typeId: 100, adapterName: 'OrderModelAdapter')
  factory OrderModel({
    @HiveField(0) required String orderId,
    @HiveField(1) required String date,
    @HiveField(2) required String time,
    @HiveField(3) required String customerName,
    @HiveField(4) required String phoneNumber,
    @HiveField(6) String? notes,
    @HiveField(12) required String employeeName,
    @HiveField(14) required String status,
    @HiveField(15) required List<OrderInModel> orderInList,
  }) = _OrderModel;

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
}
