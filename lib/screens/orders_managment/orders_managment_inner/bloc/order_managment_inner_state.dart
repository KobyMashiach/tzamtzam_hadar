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

final class OrderManagmentLoading extends OrderManagmentInnerState {
  const OrderManagmentLoading(
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

final class OrderManagmentOnDeleteDialog extends OrderManagmentNavigatorState {
  final OrderModel order;
  const OrderManagmentOnDeleteDialog(
      {required this.order, required super.orders, required super.allOrders});
}

final class OrderManagmentOpenPrintDialog extends OrderManagmentNavigatorState {
  final OrderModel order;
  const OrderManagmentOpenPrintDialog(
      {required this.order, required super.orders, required super.allOrders});
}

final class OrderManagmentOpenAddContactDialog
    extends OrderManagmentNavigatorState {
  final String name;
  final String phoneNumber;
  const OrderManagmentOpenAddContactDialog(
      {required this.name,
      required this.phoneNumber,
      required super.orders,
      required super.allOrders});
}

final class OrderManagmentOpenSortDialog extends OrderManagmentNavigatorState {
  final List<bool>? filterOrders;
  OrderManagmentOpenSortDialog(
      {required super.orders, required super.allOrders, this.filterOrders});
}
