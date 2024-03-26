part of 'new_order_bloc.dart';

@immutable
abstract class NewOrderState {
  final String date;
  final String time;
  final String orderId;
  final List<String> categories;
  final List<String> picturesSizes;
  final List<String> picturesTypes;
  final List<String> picturesFill;
  final List<String> canvasSizes;
  final List<String> sublimationProducts;

  NewOrderState(
      {required this.date,
      required this.time,
      required this.orderId,
      required this.categories,
      required this.picturesSizes,
      required this.picturesTypes,
      required this.picturesFill,
      required this.canvasSizes,
      required this.sublimationProducts});
}

final class NewOrderInitial extends NewOrderState {
  NewOrderInitial(
      {required super.date,
      required super.time,
      required super.orderId,
      required super.categories,
      required super.picturesSizes,
      required super.picturesTypes,
      required super.picturesFill,
      required super.canvasSizes,
      required super.sublimationProducts});
}

final class NewOrderFetchData extends NewOrderState {
  NewOrderFetchData(
      {required super.date,
      required super.time,
      required super.orderId,
      required super.categories,
      required super.picturesSizes,
      required super.picturesTypes,
      required super.picturesFill,
      required super.canvasSizes,
      required super.sublimationProducts});
}

final class NewOrderOnLoading extends NewOrderState {
  NewOrderOnLoading(
      {required super.date,
      required super.time,
      required super.orderId,
      required super.categories,
      required super.picturesSizes,
      required super.picturesTypes,
      required super.picturesFill,
      required super.canvasSizes,
      required super.sublimationProducts});
}

final class NewOrderGetAmount extends NewOrderState {
  final int amount;
  NewOrderGetAmount(
      {required this.amount,
      required super.date,
      required super.time,
      required super.orderId,
      required super.categories,
      required super.picturesSizes,
      required super.picturesTypes,
      required super.picturesFill,
      required super.canvasSizes,
      required super.sublimationProducts});
}

final class NewOrderOnNewOrderState extends NewOrderState {
  final bool newCustomer;
  NewOrderOnNewOrderState(
      {required this.newCustomer,
      required super.date,
      required super.time,
      required super.orderId,
      required super.categories,
      required super.picturesSizes,
      required super.picturesTypes,
      required super.picturesFill,
      required super.canvasSizes,
      required super.sublimationProducts});
}

@immutable
abstract class NewOrderNavigationState extends NewOrderState {
  NewOrderNavigationState(
      {required super.date,
      required super.time,
      required super.orderId,
      required super.categories,
      required super.picturesSizes,
      required super.picturesTypes,
      required super.picturesFill,
      required super.canvasSizes,
      required super.sublimationProducts});
}

final class NewOrderNavigationNavToHomeScreen extends NewOrderNavigationState {
  NewOrderNavigationNavToHomeScreen(
      {required super.date,
      required super.time,
      required super.orderId,
      required super.categories,
      required super.picturesSizes,
      required super.picturesTypes,
      required super.picturesFill,
      required super.canvasSizes,
      required super.sublimationProducts});
}
