part of 'order_managment_root_bloc.dart';

@immutable
abstract class OrderManagmentRootEvent {}

class HomePageEventInitial extends OrderManagmentRootEvent {}

@immutable
class HomePageEventNavigatiotn extends OrderManagmentRootEvent {}

class HomePageEventNavigateToPage extends HomePageEventNavigatiotn {
  final int pageIndex;
  HomePageEventNavigateToPage({required this.pageIndex});
}
