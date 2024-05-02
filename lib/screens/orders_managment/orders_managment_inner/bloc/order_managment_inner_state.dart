part of 'order_managment_inner_bloc.dart';

@immutable
abstract class OrderManagmentInnerState {
  final Map<String, Map<String, OrderModel>> orders;
  final List<OrderModel> allOrders;
  const OrderManagmentInnerState(
      {required this.orders, required this.allOrders});
}

final class OrderManagmentInitial extends OrderManagmentInnerState {
  const OrderManagmentInitial(
      {required super.orders, required super.allOrders});
}

@immutable
abstract class OrderManagmentNavigatorState extends OrderManagmentInnerState {
  const OrderManagmentNavigatorState(
      {required super.orders, required super.allOrders});
}

final class OrderManagmentNavigateToPage extends OrderManagmentNavigatorState {
  const OrderManagmentNavigateToPage(
      {required super.orders, required super.allOrders});
}

final class OrderManagmentChangeStatusDialog
    extends OrderManagmentNavigatorState {
  final OrderModel order;
  const OrderManagmentChangeStatusDialog(
      {required this.order, required super.orders, required super.allOrders});
}
