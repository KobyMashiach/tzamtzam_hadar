import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tzamtzam_hadar/core/enums.dart';
import 'package:tzamtzam_hadar/models/orders_model.dart';
import 'package:tzamtzam_hadar/services/firestore_data.dart';

class OrdersRepo {
  final collection = FirebaseFirestore.instance.collection('Orders');

  //ToDo: check data in hive

  void setNewOrdersCollection() {
    firestoreNewDoc(collection, docName: "progress");
  }

  void newOrUpdateOrderToFirestore(OrderModel order) {
    final Map<String, dynamic> orderMap = order.toMap();
    firestoreUpdateDoc(collection,
        docName: order.status, values: {order.orderId: orderMap});
  }

  void clearOrdersTable() {
    firestoreClearDoc(collection, docName: "progress");
  }
}
