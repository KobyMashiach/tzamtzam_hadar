part of 'home_page_bloc.dart';

@immutable
abstract class HomePageState {}

final class HomePageInitial extends HomePageState {}

@immutable
abstract class HomePageNavigationState extends HomePageState {}

final class HomePageCategoryNavigation extends HomePageNavigationState {
  final int page;
  HomePageCategoryNavigation({required this.page});
}
