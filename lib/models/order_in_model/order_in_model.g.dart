// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_in_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderModelAdapter extends TypeAdapter<_$OrderInModelImpl> {
  @override
  final int typeId = 103;

  @override
  _$OrderInModelImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$OrderInModelImpl(
      category: fields[0] as String,
      amount: fields[1] as int,
      photoSize: fields[2] as String?,
      photoType: fields[3] as String?,
      photoFill: fields[4] as String?,
      canvasSize: fields[5] as String?,
      sublimationProduct: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, _$OrderInModelImpl obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.category)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.photoSize)
      ..writeByte(3)
      ..write(obj.photoType)
      ..writeByte(4)
      ..write(obj.photoFill)
      ..writeByte(5)
      ..write(obj.canvasSize)
      ..writeByte(6)
      ..write(obj.sublimationProduct);
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
      category: json['category'] as String,
      amount: (json['amount'] as num).toInt(),
      photoSize: json['photoSize'] as String?,
      photoType: json['photoType'] as String?,
      photoFill: json['photoFill'] as String?,
      canvasSize: json['canvasSize'] as String?,
      sublimationProduct: json['sublimationProduct'] as String?,
    );

Map<String, dynamic> _$$OrderInModelImplToJson(_$OrderInModelImpl instance) =>
    <String, dynamic>{
      'category': instance.category,
      'amount': instance.amount,
      'photoSize': instance.photoSize,
      'photoType': instance.photoType,
      'photoFill': instance.photoFill,
      'canvasSize': instance.canvasSize,
      'sublimationProduct': instance.sublimationProduct,
    };
