part of 'order_managment_bloc.dart';

@immutable
abstract class OrderManagmentState {
  final List<OrderModel> orders;
  const OrderManagmentState({required this.orders});
}

final class OrderManagmentInitial extends OrderManagmentState {
  const OrderManagmentInitial({required super.orders});
}

@immutable
abstract class OrderManagmentNavigatorState extends OrderManagmentState {
  const OrderManagmentNavigatorState({required super.orders});
}

final class OrderManagmentNavigateToPage extends OrderManagmentNavigatorState {
  const OrderManagmentNavigateToPage({required super.orders});
}
