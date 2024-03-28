import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tzamtzam_hadar/hive/orders_data_source.dart';
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
    on<OrderManagmentEventClearOrders>(_orderManagmentEventClearOreders);
  }

  FutureOr<void> _orderManagmentEventInitial(OrderManagmentEventInitial event,
      Emitter<OrderManagmentInnerState> emit) {
    orders = OrdersDataSource.getOrders();
    emit(OrderManagmentInitial(orders: orders));
  }

  FutureOr<void> _orderManagmentEventClearOreders(
      OrderManagmentEventClearOrders event,
      Emitter<OrderManagmentInnerState> emit) async {
    await OrdersDataSource.clearOrders();
    repo.clearOrdersTable();
  }
}
