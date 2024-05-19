import 'package:hive_flutter/hive_flutter.dart';
import 'package:tzamtzam_hadar/models/order_model/orders_model.dart';

class OrdersDataSource {
  static const _orderBox = OrderModel.hiveKey;
  static const _lastUpdateBox = 'firestoreOrdersLastUpdate';

  static Future initialise() async {
    if (!Hive.isBoxOpen(_orderBox)) {
      await Hive.openBox<OrderModel>(_orderBox);
    }
    if (!Hive.isBoxOpen(_lastUpdateBox)) {
      await Hive.openBox(_lastUpdateBox);
    }
  }

  Future addOrder({required OrderModel order}) async {
    final ordersBox = Hive.box<OrderModel>(_orderBox);
    await ordersBox.add(order);
  }

  List<OrderModel> getOrders() {
    final ordersBox = Hive.box<OrderModel>(_orderBox);
    final orders = ordersBox.values.map((e) => e).toList();
    return orders;
  }

  DateTime? getLastUpdate() {
    final ordersBox = Hive.box(_lastUpdateBox);
    final lastUpdate = ordersBox.values.map((e) => e).toList();
    return lastUpdate.isEmpty ? null : lastUpdate.first;
  }

  void saveAllData(Map<String, Map<String, dynamic>> allData) {
    // final lastUpdateBox = Hive.box(_lastUpdateBox);
    // final orderBox = Hive.box(_orderBox);

    // // clean boxes
    // lastUpdateBox.clear();
    // orderBox.clear();

    // // add data
    // lastUpdateBox
    //     .add(((allData[0] as Map<String, dynamic>)).values.first.toDate());
    // orderBox.add(allData[1] as Map<String, dynamic>);
  }

  Future clearOrders() async {
    final ordersBox = Hive.box<OrderModel>(_orderBox);
    await ordersBox.clear();
  }

  Future saveOrders(List<OrderModel> orders) async {
    final ordersBox = Hive.box<OrderModel>(_orderBox);
    await ordersBox.clear();
    await ordersBox.addAll(orders);
  }

  Future deleteOrder(OrderModel order) async {
    final ordersBox = Hive.box<OrderModel>(_orderBox);
    final orders = ordersBox.values.map((e) => e).toList();
    orders.removeWhere((element) => element.orderId == order.orderId);
    await ordersBox.clear();
    await ordersBox.addAll(orders);
  }
}
