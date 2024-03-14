import 'package:flutter/material.dart';
import 'package:tzamtzam_hadar/models/orders_model.dart';

class OrderManagmentCard extends StatelessWidget {
  const OrderManagmentCard({
    super.key,
    required this.order,
  });

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Text(order.toString());
  }
}
