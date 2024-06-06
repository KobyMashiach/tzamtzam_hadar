import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'order_in_model.freezed.dart';
part 'order_in_model.g.dart';

//extends HiveObject
// @HiveType(typeId: 100)

@freezed
class OrderInModel with _$OrderInModel {
  static const String hiveKey = 'orderModel';
  @HiveType(typeId: 103, adapterName: 'OrderModelAdapter')
  factory OrderInModel({
    @HiveField(0) required String category,
    @HiveField(1) required int amount,
    @HiveField(2) String? photoSize,
    @HiveField(3) String? photoType,
    @HiveField(4) String? photoFill,
    @HiveField(5) String? canvasSize,
    @HiveField(6) String? sublimationProduct,
  }) = _OrderInModel;

  factory OrderInModel.fromJson(Map<String, dynamic> json) =>
      _$OrderInModelFromJson(json);
}
