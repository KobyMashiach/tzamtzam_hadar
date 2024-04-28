import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kh_easy_dev/kh_easy_dev.dart';
import 'package:meta/meta.dart';
import 'package:tzamtzam_hadar/core/translates/get_tran.dart';
import 'package:tzamtzam_hadar/models/contact_model.dart';
import 'package:tzamtzam_hadar/repos/lists_maps_repo.dart';
import 'package:tzamtzam_hadar/repos/orders_repo.dart';
import 'package:tzamtzam_hadar/services/general_lists.dart';

part 'managment_event.dart';
part 'managment_state.dart';

class ManagmentBloc extends Bloc<ManagmentEvent, ManagmentState> {
  List<String> managmentList = [];
  Map<String, List<ContactModel>> contacts = {};
  final OrdersRepo orderRepo;
  final ListsMapsRepo listsMapsRepo;
  ManagmentBloc({required this.orderRepo, required this.listsMapsRepo})
      : super(ManagmentStateInitial(managmentList: [])) {
    on<ManagmentEventInit>(_managmentEventInit);
    on<ManagmentEventOpenDialog>(_managmentEventOpenDialog);
    on<ManagmentEventClearOrders>(_managmentEventClearOrders);
    on<ManagmentEventAddNewSendFilesItem>(_managmentEventAddNewSendFilesItem);
  }

  FutureOr<void> _managmentEventInit(
      ManagmentEventInit event, Emitter<ManagmentState> emit) {
    managmentList = globalManagmentCategoriesTranslated;
    contacts = globalContactsListTranslated;
    contacts.forEach((key, value) {
      value.sort((a, b) => a.name.compareTo(b.name));
    });
    log(managmentList.toString());
    emit(ManagmentStateInitial(managmentList: managmentList));
  }

  FutureOr<void> _managmentEventOpenDialog(
      ManagmentEventOpenDialog event, Emitter<ManagmentState> emit) {
    switch (event.index) {
      case 0:
        emit(ManagmentNavigationOpenSendFilesDialog(
            index: event.index, managmentList: managmentList));
      case 1:
        if (orderRepo.getAllOrders().isNotEmpty) {
          emit(ManagmentNavigationOpenDeleteAllOrdersDialog(
              managmentList: managmentList));
        } else {
          kheasydevAppToast(appTranslate("not_order_found"));
        }
      case 2:
        emit(ManagmentNavigationNavToContactsPage(
            contacts: contacts, managmentList: managmentList));
    }
  }

  FutureOr<void> _managmentEventClearOrders(
      ManagmentEventClearOrders event, Emitter<ManagmentState> emit) async {
    await orderRepo.clearOrdersTable();
    kheasydevAppToast(appTranslate("all_orders_deleted"));
  }

  FutureOr<void> _managmentEventAddNewSendFilesItem(
      ManagmentEventAddNewSendFilesItem event,
      Emitter<ManagmentState> emit) async {
    listsMapsRepo.uploadNewSendFiles(
      title: event.title,
      description: event.description,
      type: event.type,
      networkUrl: event.networkUrl,
      image: event.image,
      qrImage: event.qrImage,
      emailLink: event.emailLink,
    );
  }
}
