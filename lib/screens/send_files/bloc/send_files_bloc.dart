import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:tzamtzam_hadar/models/send_files_model.dart';
import 'package:tzamtzam_hadar/repos/lists_maps_repo.dart';
import 'package:tzamtzam_hadar/services/firestore_data.dart';
import 'package:tzamtzam_hadar/services/general_lists.dart';

part 'send_files_event.dart';
part 'send_files_state.dart';

class SendFilesBloc extends Bloc<SendFilesEvent, SendFilesState> {
  List<SendFilesModel> sendFilesList = [];
  final ListsMapsRepo listsMapsRepo;

  SendFilesBloc(this.listsMapsRepo)
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
    firestoreNewDoc(FirebaseFirestore.instance.collection('Orders'),
        docName: 'progress'); //ToDo ==> move to splash screen
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
    await listsMapsRepo.removeItemFromSendFiles(name: event.item.name);
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

    await listsMapsRepo.uploadNewSendFiles(
      title: event.title,
      description: event.description,
      type: event.type,
      networkUrl: event.networkUrl,
      image: event.image,
      qrImage: event.qrImage,
      emailLink: event.emailLink,
    );
    if (event.oldTitle != event.title)
      await listsMapsRepo.removeItemFromSendFiles(name: event.oldTitle);
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
