import 'package:tzamtzam_hadar/core/translates/get_tran.dart';
import 'package:tzamtzam_hadar/screens/new_order/new_order.dart';
import 'package:intl/intl.dart';

List<String> categoriesList(context) => [
      appTranslate(context, "general"),
      appTranslate(context, "pictures"),
      appTranslate(context, "sublimation"),
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

Map<String, dynamic> mainCategories(context) => {
      appTranslate(context, "new_order"): NewOrder(
        title: appTranslate(context, "new_order"),
        date: DateFormat('dd/MM/yyyy').format(DateTime.now()),
        time: DateFormat('hh:mm').format(DateTime.now()),
      ),
      // appTranslate(context, "orders_managment"):
      //     NewOrder(title: appTranslate(context, "orders_managment")),
      // appTranslate(context, "orders_history"):
      //     NewOrder(title: appTranslate(context, "orders_history")),
    };
