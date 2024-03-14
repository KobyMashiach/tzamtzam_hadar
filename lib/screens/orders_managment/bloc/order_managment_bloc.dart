import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tzamtzam_hadar/hive/orders_data_source.dart';
import 'package:tzamtzam_hadar/models/orders_model.dart';

part 'order_managment_event.dart';
part 'order_managment_state.dart';

class OrderManagmentBloc
    extends Bloc<OrderManagmentEvent, OrderManagmentState> {
  List<OrderModel> orders = [];
  OrderManagmentBloc() : super(OrderManagmentInitial(orders: [])) {
    on<OrderManagmentEventInitial>(_orderManagmentEventInitial);
  }

  FutureOr<void> _orderManagmentEventInitial(
      OrderManagmentEventInitial event, Emitter<OrderManagmentState> emit) {
    orders = OrdersDataSource.getOrders();
    emit(OrderManagmentInitial(orders: orders));
  }
}
