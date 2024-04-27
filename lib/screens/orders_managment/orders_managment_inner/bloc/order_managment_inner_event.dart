part of 'order_managment_inner_bloc.dart';

@immutable
abstract class OrderManagmentInnerEvent {}

class OrderManagmentEventInitial extends OrderManagmentInnerEvent {}

class OrderManagmentEventDeleteOrder extends OrderManagmentInnerEvent {
  final OrderModel order;

  OrderManagmentEventDeleteOrder(this.order);
}

class OrderManagmentEventEditOrder extends OrderManagmentInnerEvent {
  final OrderModel order;

  OrderManagmentEventEditOrder(this.order);
}
