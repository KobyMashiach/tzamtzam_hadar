part of 'order_managment_inner_bloc.dart';

@immutable
abstract class OrderManagmentInnerEvent {}

class OrderManagmentEventInitial extends OrderManagmentInnerEvent {}

class OrderManagmentEventDeleteOrder extends OrderManagmentInnerEvent {
  final OrderModel order;
  OrderManagmentEventDeleteOrder(this.order);
}

class OrderManagmentEventChangeOrderStatusOpenDialog
    extends OrderManagmentInnerEvent {
  final OrderModel order;
  OrderManagmentEventChangeOrderStatusOpenDialog(this.order);
}

class OrderManagmentEventChangeOrderStatus extends OrderManagmentInnerEvent {
  final OrderModel order;
  final String status;
  OrderManagmentEventChangeOrderStatus(
      {required this.order, required this.status});
}
