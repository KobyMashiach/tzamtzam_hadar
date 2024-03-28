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
  }

  FutureOr<void> _sendFilesEventInit(
      SendFilesEventInit event, Emitter<SendFilesState> emit) {
    firestoreNewDoc(FirebaseFirestore.instance.collection('Orders'),
        docName: 'progress'); //ToDo ==> move to splash screen
    final Map<String, dynamic> sendFileMap = sendFilesMap();
    sendFilesList = sendFileMap.entries
        .map((entry) => SendFilesModel(
            name: entry.key,
            type: entry.value['type'],
            networkUrl: entry.value['networkUrl'],
            imageUrl: entry.value['imageUrl'],
            qrCode: entry.value['qrCode']))
        .toList();
    emit(SendFilesInitial(sendFilesList: sendFilesList));
  }
}
