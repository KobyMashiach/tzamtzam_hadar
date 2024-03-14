import 'package:hive/hive.dart';
import 'package:tzamtzam_hadar/models/orders_model.dart';

class AdaptersController {
  static void registerAdapters() {
    Hive.registerAdapter<OrderModel>(OrderModelAdapter());
  }
}
