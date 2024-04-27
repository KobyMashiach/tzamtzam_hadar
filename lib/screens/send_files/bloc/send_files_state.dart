part of 'send_files_bloc.dart';

@immutable
abstract class SendFilesState {
  final List<SendFilesModel> sendFilesList;

  SendFilesState({required this.sendFilesList});
}

final class SendFilesInitial extends SendFilesState {
  SendFilesInitial({required super.sendFilesList});
}

final class SendFilesLoading extends SendFilesState {
  SendFilesLoading({required super.sendFilesList});
}
