import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tzamtzam_hadar/core/enums.dart';
import 'package:tzamtzam_hadar/hive/orders_data_source.dart';
import 'package:tzamtzam_hadar/models/order_in_model/order_in_model.dart';
import 'package:tzamtzam_hadar/models/order_model/orders_model.dart';
import 'package:tzamtzam_hadar/services/firestore_data.dart';

class OrdersRepo {
  OrdersRepo(this.localDB);
  final collection = FirebaseFirestore.instance.collection('Orders');
  final OrdersDataSource localDB;

  //TODO: check data in hive

  // Future<Map<String, Map<String, OrderModel>>> getAllOrders() async {
  Future<(List<OrderModel>, Map<String, Map<String, OrderModel>>)>
      getAllOrders() async {
    // final lastUpdateDB = localDB.getLastUpdate();
    // final lastUpdateFS =
    //     (await firestoreGetDataFromDoc(collection, 'last_update', "lastUpdate"))
    //         .toDate();

    // if (lastUpdateDB == null || !lastUpdateDB.isAtSameMomentAs(lastUpdateFS)) {
    // QuerySnapshot querySnapshot = await collection.get();
    // final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    final Map<String, Map<String, dynamic>> allData =
        await firestoreGetCollection(collection);
    final Map<String, Map<String, OrderModel>> orders = {};
    final List<OrderModel> allOrders = [];

    allData.forEach((key, value) {
      if (!orders.containsKey(key)) {
        orders[key] = {};
      }
      if (value.isNotEmpty) {
        value.forEach((innerKey, innerValue) {
          OrderModel order = OrderModel.fromJson(innerValue);
          orders[key]![innerKey] = order;
          allOrders.add(order);
        });
      } else {
        orders[key] = {};
      }
    });

    allOrders.sort((a, b) => a.orderId.compareTo(b.orderId));

    return (allOrders, orders);
    // } else {
    // return localDB.getOrders();
    // }
  }

  void newOrUpdateOrderToFirestore(OrderModel order) {
    //TODO: from here
    final Map<String, dynamic> orderMap = order.toJson();
    List<OrderInModel> orderIn = orderMap["orderInList"];
    final checkJson = orderIn.first.toJson();
    orderMap["orderInList"] = [checkJson];
    firestoreUpdateDoc(collection,
        docName: order.status, values: {order.orderId: orderMap});
  }

  void changeOrderStatusToFirestore(OrderModel order, String status) {
    final Map<String, dynamic> orderMap = order.toJson();
    orderMap["status"] = status;
    firestoreUpdateDoc(collection,
        docName: status, values: {order.orderId: orderMap});
    firestoreDeleteField(collection,
        docName: order.status, fieldName: order.orderId);
  }

  Future<void> clearOrdersTable() async {
    // await localDB.clearOrders();
    _clearFirestoreOrders();
  }

  Future<void> deleteOrder(OrderModel order) async {
    firestoreDeleteField(collection,
        docName: order.status, fieldName: order.orderId);
  }

  _clearFirestoreOrders() {
    firestoreClearDoc(collection, docName: "progress");
    firestoreClearDoc(collection, docName: "done");
    firestoreClearDoc(collection, docName: "hold");
  }
}
