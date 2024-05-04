import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kh_easy_dev/kh_easy_dev.dart';
import 'package:meta/meta.dart';
import 'package:tzamtzam_hadar/core/translates/get_tran.dart';
import 'package:tzamtzam_hadar/models/send_files_model.dart';
import 'package:tzamtzam_hadar/repos/send_files_repo.dart';
import 'package:tzamtzam_hadar/services/firestore_data.dart';
import 'package:tzamtzam_hadar/services/general_lists.dart';

part 'send_files_event.dart';
part 'send_files_state.dart';

class SendFilesBloc extends Bloc<SendFilesEvent, SendFilesState> {
  List<SendFilesModel> sendFilesList = [];
  final SendFilesRepo sendFilesRepo;

  SendFilesBloc(this.sendFilesRepo)
      : super(SendFilesInitial(sendFilesList: [])) {
    on<SendFilesEventInit>(_sendFilesEventInit);
    on<SendFilesOnLoadingScreen>(_sendFilesOnLoadingScreen);
    on<SendFilesOnDeleteItem>(_sendFilesOnDeleteItem);
    on<SendFilesOnEditItem>(_sendFilesOnEditItem);
    on<SendFilesOnSaveEditItem>(_sendFilesOnSaveEditItem);
    on<SendFilesOnDoneLoading>(_sendFilesOnDoneLoading);
  }

  FutureOr<void> _sendFilesEventInit(
      SendFilesEventInit event, Emitter<SendFilesState> emit) async {
    refreshUIFunction(emit);
  }

  void refreshUIFunction(Emitter<SendFilesState> emit) {
    final Map<String, dynamic> sendFileMap = globalSendFilesTranslated;
    sendFilesList = sendFileMap.entries
        .map((entry) => SendFilesModel(
              name: entry.key,
              type: entry.value['type'],
              description: entry.value['description'],
              networkUrl: entry.value['networkUrl'],
              imageUrl: entry.value['imageUrl'],
              qrCode: entry.value['qrCode'],
              emailLink: entry.value['emailLink'],
            ))
        .toList();
    emit(SendFilesInitial(sendFilesList: sendFilesList));
  }

  FutureOr<void> _sendFilesOnDeleteItem(
      SendFilesOnDeleteItem event, Emitter<SendFilesState> emit) async {
    emit(SendFilesLoading(sendFilesList: sendFilesList));
    await sendFilesRepo.removeItemFromSendFiles(name: event.item.name);
    kheasydevAppToast(appTranslate("send_item_deleted",
        arguments: {"name": event.item.name}));
    refreshUIFunction(emit);
  }

  FutureOr<void> _sendFilesOnEditItem(
      SendFilesOnEditItem event, Emitter<SendFilesState> emit) async {
    emit(SendFilesOpenEditDialog(
        item: event.item, sendFilesList: sendFilesList));
  }

  FutureOr<void> _sendFilesOnSaveEditItem(
      SendFilesOnSaveEditItem event, Emitter<SendFilesState> emit) async {
    emit(SendFilesLoading(sendFilesList: sendFilesList));
    await sendFilesRepo.uploadNewSendFiles(
      title: event.title,
      description: event.description,
      type: event.type,
      networkUrl: event.networkUrl,
      image: event.image,
      qrImage: event.qrImage,
      emailLink: event.emailLink,
    );
    if (event.oldTitle != event.title)
      await sendFilesRepo.removeItemFromSendFiles(name: event.oldTitle);
    kheasydevAppToast(
        appTranslate("send_item_updated", arguments: {"name": event.title}));
    refreshUIFunction(emit);

    emit(SendFilesInitial(sendFilesList: sendFilesList));
  }

  FutureOr<void> _sendFilesOnLoadingScreen(
      SendFilesOnLoadingScreen event, Emitter<SendFilesState> emit) {
    emit(SendFilesLoading(sendFilesList: sendFilesList));
  }

  FutureOr<void> _sendFilesOnDoneLoading(
      SendFilesOnDoneLoading event, Emitter<SendFilesState> emit) {
    emit(SendFilesInitial(sendFilesList: sendFilesList));
  }
}
