// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_in_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderModelAdapter extends TypeAdapter<_$OrderInModelImpl> {
  @override
  final int typeId = 100;

  @override
  _$OrderInModelImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$OrderInModelImpl(
      photoSize: fields[0] as String?,
      photoType: fields[1] as String?,
      photoFill: fields[2] as String?,
      canvasSize: fields[3] as String?,
      sublimationProduct: fields[4] as String?,
      amount: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, _$OrderInModelImpl obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.photoSize)
      ..writeByte(1)
      ..write(obj.photoType)
      ..writeByte(2)
      ..write(obj.photoFill)
      ..writeByte(3)
      ..write(obj.canvasSize)
      ..writeByte(4)
      ..write(obj.sublimationProduct)
      ..writeByte(5)
      ..write(obj.amount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderInModelImpl _$$OrderInModelImplFromJson(Map<String, dynamic> json) =>
    _$OrderInModelImpl(
      photoSize: json['photoSize'] as String?,
      photoType: json['photoType'] as String?,
      photoFill: json['photoFill'] as String?,
      canvasSize: json['canvasSize'] as String?,
      sublimationProduct: json['sublimationProduct'] as String?,
      amount: (json['amount'] as num).toInt(),
    );

Map<String, dynamic> _$$OrderInModelImplToJson(_$OrderInModelImpl instance) =>
    <String, dynamic>{
      'photoSize': instance.photoSize,
      'photoType': instance.photoType,
      'photoFill': instance.photoFill,
      'canvasSize': instance.canvasSize,
      'sublimationProduct': instance.sublimationProduct,
      'amount': instance.amount,
    };
