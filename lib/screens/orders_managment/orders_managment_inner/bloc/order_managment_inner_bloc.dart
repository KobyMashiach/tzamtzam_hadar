import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:kh_easy_dev/kh_easy_dev.dart';
import 'package:meta/meta.dart';
import 'package:tzamtzam_hadar/core/translates/get_tran.dart';
import 'package:tzamtzam_hadar/models/orders_model.dart';
import 'package:tzamtzam_hadar/repos/contacts_repo.dart';
import 'package:tzamtzam_hadar/repos/orders_repo.dart';

part 'order_managment_inner_event.dart';
part 'order_managment_inner_state.dart';

class OrderManagmentInnerBloc
    extends Bloc<OrderManagmentInnerEvent, OrderManagmentInnerState> {
  final OrdersRepo repo;
  final ContactsRepo contactsRepo;

  Map<String, Map<String, OrderModel>> orders = {};
  List<OrderModel> allOrders = [];
  OrderManagmentInnerBloc(this.repo, this.contactsRepo)
      : super(OrderManagmentInitial(orders: {}, allOrders: [])) {
    on<OrderManagmentEventInitial>(_orderManagmentEventInitial);
    on<OrderManagmentEventDeleteOrder>(_orderManagmentEventDeleteOrder);
    on<OrderManagmentEventChangeOrderStatusOpenDialog>(
        _orderManagmentEventChangeOrderStatusOpenDialog);
    on<OrderManagmentEventChangeOrderStatus>(
        _orderManagmentEventChangeOrderStatus);
    on<OrderManagmentEventOpenPrintDialog>(_orderManagmentEventOpenPrintDialog);
    on<OrderManagmentEventOpenAddContactDialog>(
        _orderManagmentEventOpenAddContactDialog);
    on<OrderManagmentEventOnAddNewContact>(_orderManagmentEventOnAddNewContact);
  }

  FutureOr<void> _orderManagmentEventInitial(OrderManagmentEventInitial event,
      Emitter<OrderManagmentInnerState> emit) async {
    final data = await repo.getAllOrders();
    allOrders = data.$1;
    orders = data.$2;
    emit(OrderManagmentInitial(orders: orders, allOrders: allOrders));
  }

  FutureOr<void> _orderManagmentEventDeleteOrder(
      OrderManagmentEventDeleteOrder event,
      Emitter<OrderManagmentInnerState> emit) async {
    await repo.deleteOrder(event.order);
    final order = allOrders
        .removeWhere((element) => element.orderId == event.order.orderId);

    emit(buildRefreshUI());
  }

  OrderManagmentInitial buildRefreshUI() =>
      OrderManagmentInitial(orders: orders, allOrders: allOrders);

  FutureOr<void> _orderManagmentEventChangeOrderStatusOpenDialog(
      OrderManagmentEventChangeOrderStatusOpenDialog event,
      Emitter<OrderManagmentInnerState> emit) {
    emit(OrderManagmentChangeStatusDialog(
        order: event.order, orders: orders, allOrders: allOrders));
  }

  FutureOr<void> _orderManagmentEventChangeOrderStatus(
      OrderManagmentEventChangeOrderStatus event,
      Emitter<OrderManagmentInnerState> emit) async {
    repo.changeOrderStatusToFirestore(event.order, event.status);
    final order = allOrders
        .firstWhere((element) => element.orderId == event.order.orderId);
    order.status = event.status;
    emit(buildRefreshUI());
  }

  FutureOr<void> _orderManagmentEventOpenPrintDialog(
      OrderManagmentEventOpenPrintDialog event,
      Emitter<OrderManagmentInnerState> emit) {
    emit(OrderManagmentOpenPrintDialog(
        order: event.order, orders: orders, allOrders: allOrders));
  }

  FutureOr<void> _orderManagmentEventOpenAddContactDialog(
      OrderManagmentEventOpenAddContactDialog event,
      Emitter<OrderManagmentInnerState> emit) {
    emit(OrderManagmentOpenAddContactDialog(
        name: event.name,
        phoneNumber: event.phoneNumber,
        orders: orders,
        allOrders: allOrders));
  }

  FutureOr<void> _orderManagmentEventOnAddNewContact(
      OrderManagmentEventOnAddNewContact event,
      Emitter<OrderManagmentInnerState> emit) async {
    emit(OrderManagmentLoading(orders: orders, allOrders: allOrders));
    await contactsRepo.uploadNewContact(
        name: event.name, phoneNumber: event.phoneNumber, group: event.group);
    emit(buildRefreshUI());
    kheasydevAppToast(
        appTranslate("contact_uploaded", arguments: {"name": event.name}));
  }
}
