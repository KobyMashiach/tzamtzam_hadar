import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tzamtzam_hadar/hive/orders_data_source.dart';
import 'package:tzamtzam_hadar/models/orders_model.dart';
import 'package:tzamtzam_hadar/services/firestore_data.dart';

class OrdersRepo {
  OrdersRepo(this.localDB);
  final collection = FirebaseFirestore.instance.collection('Orders');
  final OrdersDataSource localDB;

  //TODO: check data in hive

  List<OrderModel> getAllOrders() {
    return localDB.getOrders();
  }

  void setNewOrdersCollection() {
    firestoreNewDoc(collection, docName: "progress");
    firestoreNewDoc(collection, docName: "done");
    firestoreNewDoc(collection, docName: "hold");
  }

  void newOrUpdateOrderToFirestore(OrderModel order) {
    final Map<String, dynamic> orderMap = order.toMap();
    firestoreUpdateDoc(collection,
        docName: order.status, values: {order.orderId: orderMap});
  }

  Future<void> clearOrdersTable() async {
    await localDB.clearOrders();
    _clearFirestoreOrders();
  }

  Future<void> deleteOrder(OrderModel order) async {
    await localDB.deleteOrder(order);
    _clearFirestoreOrders();
    // firestoreNewDoc(collection, docName: "progress", values: orders);
    firestoreNewDoc(collection, docName: "done");
    firestoreNewDoc(collection, docName: "hold");
  }

  _clearFirestoreOrders() {
    firestoreClearDoc(collection, docName: "progress");
    firestoreClearDoc(collection, docName: "done");
    firestoreClearDoc(collection, docName: "hold");
  }
}
