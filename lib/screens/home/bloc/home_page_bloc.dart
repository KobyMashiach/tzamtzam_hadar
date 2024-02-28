import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomePageInitial()) {
    on<HomePageEventInitial>(_homePageEventInitial);
    on<HomePageEventNavigateToPage>(_homePageEventNavigateToPage);
  }

  FutureOr<void> _homePageEventInitial(
      HomePageEventInitial event, Emitter<HomePageState> emit) {}

  FutureOr<void> _homePageEventNavigateToPage(
      HomePageEventNavigateToPage event, Emitter<HomePageState> emit) {
    emit(HomePageCategoryNavigation(page: event.pageIndex));
  }
}
