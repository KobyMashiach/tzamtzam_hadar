import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tzamtzam_hadar/core/translates/get_tran.dart';

part 'user_permissions.g.dart';

@HiveType(typeId: 101)
enum UserPermissions {
// extends HiveObject {
  // static const String hiveKey = 'orderModel';
  @HiveField(1)
  developer(1),

  @HiveField(2)
  admin(2),

  @HiveField(3)
  employees(3),

  @HiveField(4)
  customer(4);

  const UserPermissions(this.id);

  factory UserPermissions.fromId(int id) {
    return values.firstWhere((e) => e.id == id);
  }
  final int id;

  int toId() {
    return this.id;
  }

  List<UserPermissions> permissionsById() {
    List<UserPermissions> result = [];
    for (var value in values) {
      if (value.id <= this.id) {
        result.add(value);
      }
    }
    return result;
  }
}

extension UserPermissionsX on UserPermissions {
  String getString(BuildContext context) {
    return switch (this) {
      UserPermissions.developer => appTranslate('developer'),
      UserPermissions.admin => appTranslate('admin'),
      UserPermissions.employees => appTranslate('employees'),
      UserPermissions.customer => appTranslate('customer'),
    };
  }

  UserPermissions toUserPermissions(BuildContext context, String permission) {
    String translatedPermission = appTranslate(permission);
    if (translatedPermission == appTranslate('developer')) {
      return UserPermissions.developer;
    } else if (translatedPermission == appTranslate('admin')) {
      return UserPermissions.admin;
    } else if (translatedPermission == appTranslate('employees')) {
      return UserPermissions.employees;
    } else if (translatedPermission == appTranslate('customer')) {
      return UserPermissions.customer;
    } else {
      return UserPermissions.customer;
    }
  }
}
