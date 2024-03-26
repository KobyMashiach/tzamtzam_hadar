import 'package:tzamtzam_hadar/models/user_permissions.dart';

String permissionPassword(UserPermissions permission) {
  return switch (permission) {
    UserPermissions.developer => "1111",
    UserPermissions.admin => "2222",
    UserPermissions.employees => "3333",
    UserPermissions.customer => "4444",
  };
}
