part of 'home_page_bloc.dart';

@immutable
abstract class HomePageEvent {}

class HomePageEventInitial extends HomePageEvent {}

class HomePageEventNavigateToPage extends HomePageEvent {
  final int pageIndex;
  HomePageEventNavigateToPage({required this.pageIndex});
}
