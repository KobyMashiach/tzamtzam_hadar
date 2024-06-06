// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'new_order_inner_bloc.dart';

@immutable
abstract class NewOrderInnerEvent {}

class NewOrderEventInitial extends NewOrderInnerEvent {
  final BuildContext context;
  NewOrderEventInitial(this.context);
}

class NewOrderEventAddOrder extends NewOrderInnerEvent {
  final String customerName;
  final String phoneNumber;
  final String category; //TODO: remove
  final String employeeName;
  // final int amount;
  final String? notes;
  final List<OrderInModel> itemsList;

  NewOrderEventAddOrder({
    required this.customerName,
    required this.phoneNumber,
    required this.category,
    required this.employeeName,
    required this.itemsList,
    this.notes,
  });
}

class NewOrderEventAmountChange extends NewOrderInnerEvent {
  final int amount;
  NewOrderEventAmountChange(this.amount);
}

class NewOrderEventNavToHomeScreen extends NewOrderInnerEvent {}

class NewOrderOnNewOrder extends NewOrderInnerEvent {
  final bool newCustomer;
  NewOrderOnNewOrder({required this.newCustomer});
}

class NewOrderOnDeleteItem extends NewOrderInnerEvent {
  final int index;
  NewOrderOnDeleteItem({required this.index});
}
