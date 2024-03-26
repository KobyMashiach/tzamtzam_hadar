import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tzamtzam_hadar/hive/orders_data_source.dart';
import 'package:tzamtzam_hadar/models/orders_model.dart';

part 'order_managment_inner_event.dart';
part 'order_managment_inner_state.dart';

class OrderManagmentInnerBloc
    extends Bloc<OrderManagmentInnerEvent, OrderManagmentInnerState> {
  List<OrderModel> orders = [];
  OrderManagmentInnerBloc() : super(OrderManagmentInitial(orders: [])) {
    on<OrderManagmentEventInitial>(_orderManagmentEventInitial);
  }

  FutureOr<void> _orderManagmentEventInitial(OrderManagmentEventInitial event,
      Emitter<OrderManagmentInnerState> emit) {
    orders = OrdersDataSource.getOrders();
    emit(OrderManagmentInitial(orders: orders));
  }
}
