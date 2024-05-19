import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'order_in_model.freezed.dart';
part 'order_in_model.g.dart';

//extends HiveObject
// @HiveType(typeId: 100)

@freezed
class OrderInModel with _$OrderInModel {
  static const String hiveKey = 'orderModel';
  @HiveType(typeId: 100, adapterName: 'OrderModelAdapter')
  factory OrderInModel({
    @HiveField(0) String? photoSize,
    @HiveField(1) String? photoType,
    @HiveField(2) String? photoFill,
    @HiveField(3) String? canvasSize,
    @HiveField(4) String? sublimationProduct,
    @HiveField(5) required int amount,
  }) = _OrderInModel;

  factory OrderInModel.fromJson(Map<String, dynamic> json) =>
      _$OrderInModelFromJson(json);
}
