// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_permissions.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserPermissionsAdapter extends TypeAdapter<UserPermissions> {
  @override
  final int typeId = 101;

  @override
  UserPermissions read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 1:
        return UserPermissions.developer;
      case 2:
        return UserPermissions.admin;
      case 3:
        return UserPermissions.employees;
      case 4:
        return UserPermissions.customer;
      default:
        return UserPermissions.developer;
    }
  }

  @override
  void write(BinaryWriter writer, UserPermissions obj) {
    switch (obj) {
      case UserPermissions.developer:
        writer.writeByte(1);
        break;
      case UserPermissions.admin:
        writer.writeByte(2);
        break;
      case UserPermissions.employees:
        writer.writeByte(3);
        break;
      case UserPermissions.customer:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserPermissionsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
