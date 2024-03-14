part of 'home_page_bloc.dart';

@immutable
abstract class HomePageEvent {}

class HomePageEventInitial extends HomePageEvent {}

@immutable
class HomePageEventNavigatiotn extends HomePageEvent {}

class HomePageEventNavigateToPage extends HomePageEventNavigatiotn {
  final int pageIndex;
  HomePageEventNavigateToPage({required this.pageIndex});
}
