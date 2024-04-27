import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:tzamtzam_hadar/models/send_files_model.dart';
import 'package:tzamtzam_hadar/services/firestore_data.dart';
import 'package:tzamtzam_hadar/services/general_lists.dart';

part 'send_files_event.dart';
part 'send_files_state.dart';

class SendFilesBloc extends Bloc<SendFilesEvent, SendFilesState> {
  List<SendFilesModel> sendFilesList = [];
  SendFilesBloc() : super(SendFilesInitial(sendFilesList: [])) {
    on<SendFilesEventInit>(_sendFilesEventInit);
    on<SendFilesOnDeleteItem>(_sendFilesOnDeleteItem);
    on<SendFilesOnEditItem>(_sendFilesOnEditItem);
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
            qrCode: entry.value['qrCode']))
        .toList();
    emit(SendFilesInitial(sendFilesList: sendFilesList));
  }

  FutureOr<void> _sendFilesOnDeleteItem(
      SendFilesOnDeleteItem event, Emitter<SendFilesState> emit) async {
    emit(SendFilesLoading(sendFilesList: []));
    await deleteFilesFromFolderOnStorage("sendFiles/${event.item.name}");
    globalSendFiles.removeWhere((key, value) => key == event.item.name);
    globalSendFilesTranslated
        .removeWhere((key, value) => key == event.item.name);
    final collection =
        FirebaseFirestore.instance.collection('all_lists_and_maps');
    firestoreUpdateDoc(
      collection,
      docName: 'maps',
      values: {
        "send_files_map": globalSendFiles,
      },
    );
    firestoreUpdateDoc(collection,
        docName: 'last_update',
        values: {"lastUpdate": Timestamp.fromDate(DateTime.now())});
    refreshUIFunction(emit);
  }

  FutureOr<void> _sendFilesOnEditItem(
      SendFilesOnEditItem event, Emitter<SendFilesState> emit) {}
}
