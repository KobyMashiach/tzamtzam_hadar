import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tzamtzam_hadar/hive/orders_data_source.dart';

part 'order_managment_root_event.dart';
part 'order_managment_root_state.dart';

class OrderManagmentRootBloc
    extends Bloc<OrderManagmentRootEvent, OrderManagmentRootState> {
  OrderManagmentRootBloc() : super(HomePageInitial()) {
    on<HomePageEventInitial>(_homePageEventInitial);
    on<HomePageEventNavigateToPage>(_homePageEventNavigateToPage);
  }

  FutureOr<void> _homePageEventInitial(
      HomePageEventInitial event, Emitter<OrderManagmentRootState> emit) async {
    await OrdersDataSource.initialise();
  }

  FutureOr<void> _homePageEventNavigateToPage(HomePageEventNavigateToPage event,
      Emitter<OrderManagmentRootState> emit) {
    emit(HomePageCategoryNavigation(page: event.pageIndex));
  }
}
