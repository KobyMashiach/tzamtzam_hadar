part of 'order_managment_inner_bloc.dart';

@immutable
abstract class OrderManagmentInnerState {
  final List<OrderModel> orders;
  const OrderManagmentInnerState({required this.orders});
}

final class OrderManagmentInitial extends OrderManagmentInnerState {
  const OrderManagmentInitial({required super.orders});
}

@immutable
abstract class OrderManagmentNavigatorState extends OrderManagmentInnerState {
  const OrderManagmentNavigatorState({required super.orders});
}

final class OrderManagmentNavigateToPage extends OrderManagmentNavigatorState {
  const OrderManagmentNavigateToPage({required super.orders});
}
