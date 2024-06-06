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
      notes: fields[6] as String?,
      employeeName: fields[12] as String,
      status: fields[14] as String,
      orderInList: (fields[15] as List).cast<OrderInModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, _$OrderModelImpl obj) {
    writer
      ..writeByte(9)
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
      ..writeByte(6)
      ..write(obj.notes)
      ..writeByte(12)
      ..write(obj.employeeName)
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
      notes: json['notes'] as String?,
      employeeName: json['employeeName'] as String,
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
      'notes': instance.notes,
      'employeeName': instance.employeeName,
      'status': instance.status,
      'orderInList': instance.orderInList,
    };
