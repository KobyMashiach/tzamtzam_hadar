// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderModelAdapter extends TypeAdapter<_$OrderModelImpl> {
  @override
  final int typeId = 100;

  @override
  _$OrderModelImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$OrderModelImpl(
      orderId: fields[0] as String,
      date: fields[1] as String,
      time: fields[2] as String,
      customerName: fields[3] as String,
      phoneNumber: fields[4] as String,
      category: fields[5] as String,
      notes: fields[6] as String?,
      photoSize: fields[7] as String?,
      photoType: fields[8] as String?,
      photoFill: fields[9] as String?,
      canvasSize: fields[10] as String?,
      sublimationProduct: fields[11] as String?,
      employeeName: fields[12] as String,
      amount: fields[13] as int,
      status: fields[14] as String,
      orderInList: (fields[15] as List).cast<OrderInModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, _$OrderModelImpl obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.orderId)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.time)
      ..writeByte(3)
      ..write(obj.customerName)
      ..writeByte(4)
      ..write(obj.phoneNumber)
      ..writeByte(5)
      ..write(obj.category)
      ..writeByte(6)
      ..write(obj.notes)
      ..writeByte(7)
      ..write(obj.photoSize)
      ..writeByte(8)
      ..write(obj.photoType)
      ..writeByte(9)
      ..write(obj.photoFill)
      ..writeByte(10)
      ..write(obj.canvasSize)
      ..writeByte(11)
      ..write(obj.sublimationProduct)
      ..writeByte(12)
      ..write(obj.employeeName)
      ..writeByte(13)
      ..write(obj.amount)
      ..writeByte(14)
      ..write(obj.status)
      ..writeByte(15)
      ..write(obj.orderInList);
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

_$OrderModelImpl _$$OrderModelImplFromJson(Map<String, dynamic> json) =>
    _$OrderModelImpl(
      orderId: json['orderId'] as String,
      date: json['date'] as String,
      time: json['time'] as String,
      customerName: json['customerName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      category: json['category'] as String,
      notes: json['notes'] as String?,
      photoSize: json['photoSize'] as String?,
      photoType: json['photoType'] as String?,
      photoFill: json['photoFill'] as String?,
      canvasSize: json['canvasSize'] as String?,
      sublimationProduct: json['sublimationProduct'] as String?,
      employeeName: json['employeeName'] as String,
      amount: (json['amount'] as num).toInt(),
      status: json['status'] as String,
      orderInList: (json['orderInList'] as List<dynamic>)
          .map((e) => OrderInModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$OrderModelImplToJson(_$OrderModelImpl instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'date': instance.date,
      'time': instance.time,
      'customerName': instance.customerName,
      'phoneNumber': instance.phoneNumber,
      'category': instance.category,
      'notes': instance.notes,
      'photoSize': instance.photoSize,
      'photoType': instance.photoType,
      'photoFill': instance.photoFill,
      'canvasSize': instance.canvasSize,
      'sublimationProduct': instance.sublimationProduct,
      'employeeName': instance.employeeName,
      'amount': instance.amount,
      'status': instance.status,
      'orderInList': instance.orderInList,
    };
