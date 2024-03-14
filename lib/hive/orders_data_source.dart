import 'package:hive_flutter/hive_flutter.dart';
import 'package:tzamtzam_hadar/models/orders_model.dart';

class OrdersDataSource {
  static const _orderBox = OrderModel.hiveKey;

  static Future initialise() async {
    if (!Hive.isBoxOpen(_orderBox)) {
      await Hive.openBox<OrderModel>(_orderBox);
    }
  }

  static Future addOrder({required OrderModel order}) async {
    final box = Hive.box<OrderModel>(_orderBox);
    await box.add(order);
  }

  static List<OrderModel> getOrders() {
    final box = Hive.box<OrderModel>(_orderBox);
    final orders = box.values.map((e) => e).toList();
    return orders;
  }

  static Future clearOrders() async {
    final box = Hive.box<OrderModel>(_orderBox);
    await box.clear();
  }
}
