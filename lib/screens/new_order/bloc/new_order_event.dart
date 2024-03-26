// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'new_order_bloc.dart';

@immutable
abstract class NewOrderEvent {}

class NewOrderEventInitial extends NewOrderEvent {
  final BuildContext context;
  NewOrderEventInitial(this.context);
}

class NewOrderEventAddOrder extends NewOrderEvent {
  final String customerName;
  final String phoneNumber;
  final String category;
  final String employeeName;
  final int amount;
  final String? notes;
  final String? photoSize;
  final String? photoType;
  final String? photoFill;
  final String? canvasSize;
  final String? sublimationProduct;

  NewOrderEventAddOrder(
      {required this.customerName,
      required this.phoneNumber,
      required this.category,
      required this.employeeName,
      required this.amount,
      this.notes,
      this.photoSize,
      this.photoType,
      this.photoFill,
      this.canvasSize,
      this.sublimationProduct});
}

class NewOrderEventAmountChange extends NewOrderEvent {
  final int amount;
  NewOrderEventAmountChange(this.amount);
}

class NewOrderEventNavToHomeScreen extends NewOrderEvent {}

class NewOrderOnNewOrder extends NewOrderEvent {
  final bool newCustomer;
  NewOrderOnNewOrder({required this.newCustomer});
}
