import 'package:tzamtzam_hadar/core/translates/get_tran.dart';
import 'package:tzamtzam_hadar/screens/new_order/new_order.dart';
import 'package:intl/intl.dart';

class AppLists {
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
}
