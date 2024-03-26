part of 'order_managment_root_bloc.dart';

@immutable
abstract class OrderManagmentRootState {}

final class HomePageInitial extends OrderManagmentRootState {}

@immutable
abstract class HomePageNavigationState extends OrderManagmentRootState {}

final class HomePageCategoryNavigation extends HomePageNavigationState {
  final int page;
  HomePageCategoryNavigation({required this.page});
}
