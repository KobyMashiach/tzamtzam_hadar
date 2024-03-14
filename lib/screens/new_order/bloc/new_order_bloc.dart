import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:meta/meta.dart';
import 'package:intl/intl.dart';
import 'package:tzamtzam_hadar/hive/orders_data_source.dart';
import 'package:tzamtzam_hadar/models/orders_model.dart';
import 'package:tzamtzam_hadar/services/general_lists.dart';

part 'new_order_event.dart';
part 'new_order_state.dart';

class NewOrderBloc extends Bloc<NewOrderEvent, NewOrderState> {
  String time = "";
  String date = "";
  String orderId = "";
  List<String> categories = [];
  List<String> picturesSizes = [];
  List<String> picturesTypes = [];
  List<String> picturesFill = [];
  List<String> canvasSizes = [];
  List<String> sublimationProducts = [];
  OrderModel? order;

  final OrdersDataSource repo;
  NewOrderBloc(this.repo)
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
  }

  FutureOr<void> _newOrderEventInitial(
      NewOrderEventInitial event, Emitter<NewOrderState> emit) async {
    emit(_newOrderOnLoading());
    orderId = "423";
    date = DateFormat('dd/MM/yyyy').format(DateTime.now());
    time = DateFormat('HH:mm').format(DateTime.now());
    categories = categoriesList(event.context);
    picturesSizes = picturesSizesList(event.context);
    picturesTypes = picturesTypeList(event.context);
    picturesFill = picturesFillList(event.context);
    canvasSizes = canvasSizesList(event.context);
    sublimationProducts = sublimationProductsList(event.context);

    emit(NewOrderInitial(
        date: date,
        time: time,
        orderId: orderId,
        categories: categories,
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
      NewOrderEventAddOrder event, Emitter<NewOrderState> emit) {
    order = OrderModel(
      orderId: orderId,
      date: date,
      time: time,
      customerName: event.customerName,
      phoneNumber: event.phoneNumber,
      category: event.category,
      employeeName: event.employeeName,
      canvasSize: event.canvasSize,
      photoSize: event.photoSize,
      photoFill: event.photoFill,
      photoType: event.photoType,
      notes: event.notes,
      sublimationProduct: event.sublimationProduct,
    );
    OrdersDataSource.addOrder(order: order!);
  }

  FutureOr<void> _newOrderEventAmountChange(
      NewOrderEventAmountChange event, Emitter<NewOrderState> emit) {
    emit(NewOrderGetAmount(
        amount: event.amount,
        date: date,
        time: time,
        orderId: orderId,
        categories: categories,
        picturesSizes: picturesSizes,
        picturesTypes: picturesTypes,
        picturesFill: picturesFill,
        canvasSizes: canvasSizes,
        sublimationProducts: sublimationProducts));
  }
}
