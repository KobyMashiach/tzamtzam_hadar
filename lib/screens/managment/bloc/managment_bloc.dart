import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tzamtzam_hadar/services/general_lists.dart';

part 'managment_event.dart';
part 'managment_state.dart';

class ManagmentBloc extends Bloc<ManagmentEvent, ManagmentState> {
  List<String> managmentList = [];
  ManagmentBloc() : super(ManagmentStateInitial(managmentList: [])) {
    on<ManagmentEventInit>(_managmentEventInit);
    on<ManagmentEventOpenDialog>(_managmentEventOpenDialog);
  }

  FutureOr<void> _managmentEventInit(
      ManagmentEventInit event, Emitter<ManagmentState> emit) {
    managmentList = managmentCategoriesList();
    log(managmentList.toString());
    emit(ManagmentStateInitial(managmentList: managmentList));
  }

  FutureOr<void> _managmentEventOpenDialog(
      ManagmentEventOpenDialog event, Emitter<ManagmentState> emit) {
    switch (event.index) {
      case 0:
        emit(ManagmentNavigationOpenSendFilesDialog(
          index: 0,
          managmentList: managmentList,
        ));
    }
  }
}
