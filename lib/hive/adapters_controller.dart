import 'package:hive/hive.dart';
import 'package:tzamtzam_hadar/models/orders_model.dart';
import 'package:tzamtzam_hadar/models/user_permissions.dart';

class AdaptersController {
  static void registerAdapters() {
    Hive.registerAdapter<OrderModel>(OrderModelAdapter());
    Hive.registerAdapter<UserPermissions>(UserPermissionsAdapter());
  }
}
