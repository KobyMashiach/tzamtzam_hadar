import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:tzamtzam_hadar/core/enums.dart';
import 'package:tzamtzam_hadar/hive/orders_data_source.dart';
import 'package:tzamtzam_hadar/models/order_in_model/order_in_model.dart';
import 'package:tzamtzam_hadar/models/order_model/orders_model.dart';
import 'package:tzamtzam_hadar/repos/orders_repo.dart';
import 'package:tzamtzam_hadar/services/general_functions.dart';
import 'package:tzamtzam_hadar/services/general_lists.dart';

part 'new_order_inner_event.dart';
part 'new_order_inner_state.dart';

class NewOrderInnerBloc extends Bloc<NewOrderInnerEvent, NewOrderInnerState> {
  String time = "";
  String date = "";
  String orderId = "";
  List<String> productsCategories = [];
  List<String> picturesSizes = [];
  List<String> picturesTypes = [];
  List<String> picturesFill = [];
  List<String> canvasSizes = [];
  List<String> sublimationProducts = [];
  OrderModel? order;
  List<OrderInModel> orderInList = [];

  final OrdersDataSource localDB;
  final OrdersRepo repo;
  NewOrderInnerBloc(this.localDB, this.repo)
      : super(NewOrderInitial(
            date: "",
            time: "",
            orderId: "",
            categories: [],
            picturesSizes: [],
            picturesTypes: [],
            picturesFill: [],
            canvasSizes: [],
            sublimationProducts: [])) {
    on<NewOrderEventInitial>(_newOrderEventInitial);
    on<NewOrderEventAddOrder>(_newOrderEventAddOrder);
    on<NewOrderEventAmountChange>(_newOrderEventAmountChange);
    on<NewOrderEventNavToHomeScreen>(_newOrderEventNavToHomeScreen);
    on<NewOrderOnNewOrder>(_newOrderOnNewOrder);
    on<NewOrderOnDeleteItem>(_newOrderOnDeleteItem);
  }

  FutureOr<void> _newOrderEventInitial(
      NewOrderEventInitial event, Emitter<NewOrderInnerState> emit) async {
    emit(_newOrderOnLoading());
    // final List<OrderModel> orders = localDB.getOrders();
    final data = await repo.getAllOrders();
    final List<OrderModel> orders = data.$1;
    // Map<String, OrderModel> orderMap = Map.fromIterable(
    //   orders,
    //   key: (order) => (order as OrderModel).orderId,
    //   value: (order) => order as OrderModel,
    // );

    int maxOrderId = 0;
    for (OrderModel order in orders) {
      int? currentOrderId = int.tryParse(order.orderId);
      if (currentOrderId != null && currentOrderId > maxOrderId) {
        maxOrderId = currentOrderId;
      }
    }
    //TODO: when 9999 orders reset
    // if(maxOrderId == 9999) maxOrderId = 0;
    maxOrderId++;
    orderId = GeneralFunctions().formatOrderId(maxOrderId);

    date = DateFormat('dd/MM/yyyy').format(DateTime.now());
    time = DateFormat('HH:mm').format(DateTime.now());
    productsCategories = globalProductsCategoriesTranslated;
    picturesSizes = globalPicturesSizesTranslated;
    picturesTypes = globalPicturesTypeTranslated;
    picturesFill = globalPicturesFillTranslated;
    canvasSizes = globalCanvasSizesTranslated;
    sublimationProducts = globalSublimationProductsTranslated;

    emit(NewOrderInitial(
        date: date,
        time: time,
        orderId: orderId,
        categories: productsCategories,
        picturesSizes: picturesSizes,
        picturesTypes: picturesTypes,
        picturesFill: picturesFill,
        canvasSizes: canvasSizes,
        sublimationProducts: sublimationProducts));
  }

  NewOrderOnLoading _newOrderOnLoading() {
    return NewOrderOnLoading(
        date: "",
        time: "",
        orderId: "",
        categories: [],
        picturesSizes: [],
        picturesTypes: [],
        picturesFill: [],
        canvasSizes: [],
        sublimationProducts: []);
  }

  FutureOr<void> _newOrderEventAddOrder(
      NewOrderEventAddOrder event, Emitter<NewOrderInnerState> emit) {
    // final orderList =  [
    //   OrderInModel(
    //     amount: event.amount,
    //     canvasSize: event.canvasSize,
    //     photoSize: event.photoSize,
    //     photoFill: event.photoFill,
    //     photoType: event.photoType,
    //     sublimationProduct: event.sublimationProduct,
    //   )
    // ];
    order = OrderModel(
        orderId: orderId,
        date: date,
        time: time,
        customerName: event.customerName,
        phoneNumber: event.phoneNumber,
        employeeName: event.employeeName,
        notes: event.notes,
        status: OrderStatus.progress.getStringToFirestore(),
        orderInList: event.itemsList);
    localDB.addOrder(order: order!);
    repo.newOrUpdateOrderToFirestore(order!);
  }

  FutureOr<void> _newOrderEventAmountChange(
      NewOrderEventAmountChange event, Emitter<NewOrderInnerState> emit) {
    emit(NewOrderGetAmount(
        amount: event.amount,
        date: date,
        time: time,
        orderId: orderId,
        categories: productsCategories,
        picturesSizes: picturesSizes,
        picturesTypes: picturesTypes,
        picturesFill: picturesFill,
        canvasSizes: canvasSizes,
        sublimationProducts: sublimationProducts));
  }

  FutureOr<void> _newOrderEventNavToHomeScreen(
      NewOrderEventNavToHomeScreen event, Emitter<NewOrderInnerState> emit) {
    emit(NewOrderNavigationNavToHomeScreen(
        date: date,
        time: time,
        orderId: orderId,
        categories: productsCategories,
        picturesSizes: picturesSizes,
        picturesTypes: picturesTypes,
        picturesFill: picturesFill,
        canvasSizes: canvasSizes,
        sublimationProducts: sublimationProducts));
  }

  FutureOr<void> _newOrderOnNewOrder(
      NewOrderOnNewOrder event, Emitter<NewOrderInnerState> emit) {
    emit(NewOrderOnNewOrderState(
        newCustomer: event.newCustomer,
        date: date,
        time: time,
        orderId: orderId,
        categories: productsCategories,
        picturesSizes: picturesSizes,
        picturesTypes: picturesTypes,
        picturesFill: picturesFill,
        canvasSizes: canvasSizes,
        sublimationProducts: sublimationProducts));
  }

  FutureOr<void> _newOrderOnDeleteItem(
      NewOrderOnDeleteItem event, Emitter<NewOrderInnerState> emit) {
    emit(NewOrderNavigationDeleteItemDialog(
        index: event.index,
        date: date,
        time: time,
        orderId: orderId,
        categories: productsCategories,
        picturesSizes: picturesSizes,
        picturesTypes: picturesTypes,
        picturesFill: picturesFill,
        canvasSizes: canvasSizes,
        sublimationProducts: sublimationProducts));
  }
}
