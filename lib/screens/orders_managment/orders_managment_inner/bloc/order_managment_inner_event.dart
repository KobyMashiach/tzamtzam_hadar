part of 'order_managment_inner_bloc.dart';

@immutable
abstract class OrderManagmentInnerEvent {}

class OrderManagmentEventInitial extends OrderManagmentInnerEvent {}

class OrderManagmentEventDeleteOrderDialog extends OrderManagmentInnerEvent {
  final OrderModel order;
  OrderManagmentEventDeleteOrderDialog(this.order);
}

class OrderManagmentEventDeleteOrder extends OrderManagmentInnerEvent {
  final OrderModel order;
  OrderManagmentEventDeleteOrder(this.order);
}

class OrderManagmentEventChangeOrderStatusOpenDialog
    extends OrderManagmentInnerEvent {
  final OrderModel order;
  OrderManagmentEventChangeOrderStatusOpenDialog(this.order);
}

class OrderManagmentEventChangeOrderStatus extends OrderManagmentInnerEvent {
  final OrderModel order;
  final String status;
  OrderManagmentEventChangeOrderStatus(
      {required this.order, required this.status});
}

class OrderManagmentEventOpenPrintDialog extends OrderManagmentInnerEvent {
  final OrderModel order;
  OrderManagmentEventOpenPrintDialog(this.order);
}

class OrderManagmentEventOpenAddContactDialog extends OrderManagmentInnerEvent {
  final String name;
  final String phoneNumber;

  OrderManagmentEventOpenAddContactDialog(
      {required this.name, required this.phoneNumber});
}

class OrderManagmentEventOnAddNewContact extends OrderManagmentInnerEvent {
  final String name;
  final String phoneNumber;
  final String group;

  OrderManagmentEventOnAddNewContact({
    required this.name,
    required this.phoneNumber,
    required this.group,
  });
}

class OrderManagmentEventOnSortClicked extends OrderManagmentInnerEvent {}

class OrderManagmentEventOnSorted extends OrderManagmentInnerEvent {
  final List<bool> sortCategory;

  OrderManagmentEventOnSorted(this.sortCategory);
}
