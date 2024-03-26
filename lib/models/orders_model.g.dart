// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderModelAdapter extends TypeAdapter<OrderModel> {
  @override
  final int typeId = 100;

  @override
  OrderModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrderModel(
      orderId: fields[0] as String,
      date: fields[1] as String,
      time: fields[2] as String,
      customerName: fields[3] as String,
      phoneNumber: fields[4] as String,
      category: fields[5] as String,
      employeeName: fields[12] as String?,
      amount: fields[13] as int,
      notes: fields[6] as String?,
      photoSize: fields[7] as String?,
      photoType: fields[8] as String?,
      photoFill: fields[9] as String?,
      canvasSize: fields[10] as String?,
      sublimationProduct: fields[11] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, OrderModel obj) {
    writer
      ..writeByte(14)
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
