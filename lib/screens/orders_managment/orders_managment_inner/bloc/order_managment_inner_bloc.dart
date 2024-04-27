import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tzamtzam_hadar/models/orders_model.dart';
import 'package:tzamtzam_hadar/repos/orders_repo.dart';

part 'order_managment_inner_event.dart';
part 'order_managment_inner_state.dart';

class OrderManagmentInnerBloc
    extends Bloc<OrderManagmentInnerEvent, OrderManagmentInnerState> {
  final OrdersRepo repo;
  List<OrderModel> orders = [];
  OrderManagmentInnerBloc(this.repo)
      : super(OrderManagmentInitial(orders: [])) {
    on<OrderManagmentEventInitial>(_orderManagmentEventInitial);
    on<OrderManagmentEventDeleteOrder>(_orderManagmentEventDeleteOrder);
    on<OrderManagmentEventEditOrder>(_orderManagmentEventEditOrder);
  }

  FutureOr<void> _orderManagmentEventInitial(OrderManagmentEventInitial event,
      Emitter<OrderManagmentInnerState> emit) {
    orders = repo.getAllOrders();
    emit(OrderManagmentInitial(orders: orders));
  }

  FutureOr<void> _orderManagmentEventDeleteOrder(
      OrderManagmentEventDeleteOrder event,
      Emitter<OrderManagmentInnerState> emit) async {
    await repo.deleteOrder(event.order);
    emit(buildRefreshUI());
  }

  FutureOr<void> _orderManagmentEventEditOrder(
      OrderManagmentEventEditOrder event,
      Emitter<OrderManagmentInnerState> emit) {}

  OrderManagmentInitial buildRefreshUI() =>
      OrderManagmentInitial(orders: repo.getAllOrders());
}
