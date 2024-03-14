import 'package:flutter/material.dart';
import 'package:tzamtzam_hadar/core/translates/get_tran.dart';
import 'package:tzamtzam_hadar/screens/new_order/new_order.dart';
import 'package:tzamtzam_hadar/screens/orders_managment/order_managment.dart';

List<String> categoriesList(context) => [
      appTranslate(context, "canvas"),
      appTranslate(context, "pictures"),
      appTranslate(context, "sublimation"),
      appTranslate(context, "general"),
    ];

List<String> picturesSizesList(context) => [
      "9X13",
      "10X15",
      "13X18",
      "15X21",
      "20X30",
      "30X40",
      "30X45",
      appTranslate(context, "other")
    ];

List<String> picturesTypeList(context) => [
      appTranslate(context, 'matte'),
      appTranslate(context, 'glossy'),
    ];
List<String> picturesFillList(context) => [
      appTranslate(context, 'fill_type'),
      appTranslate(context, 'fit_type'),
    ];

List<String> sublimationProductsList(context) => [
      appTranslate(context, 'basalt'),
      appTranslate(context, 'glass'),
      appTranslate(context, 'bear'),
      appTranslate(context, 'shirt'),
      appTranslate(context, 'mug'),
      appTranslate(context, 'bottle'),
    ];

List<String> canvasSizesList(context) => [
      "20X30",
      "30X40",
      "30X45",
      "35X50",
      "40X60",
      "50X70",
      "70X100",
      "20X20",
      "30X30",
      "40X40",
      "50X50",
      appTranslate(context, "other")
    ];

Map<String, dynamic> mainCategories(context) => {
      appTranslate(context, "new_order"): NewOrder(),
      appTranslate(context, "orders_managment"): OrderManagment(),
      // appTranslate(context, "orders_history"):
      //     NewOrder(title: appTranslate(context, "orders_history")),
    };
