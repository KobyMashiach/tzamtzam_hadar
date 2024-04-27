part of 'send_files_bloc.dart';

@immutable
abstract class SendFilesEvent {}

class SendFilesEventInit extends SendFilesEvent {}

class SendFilesOnDeleteItem extends SendFilesEvent {
  final SendFilesModel item;
  SendFilesOnDeleteItem({required this.item});
}

class SendFilesOnEditItem extends SendFilesEvent {
  final SendFilesModel item;
  SendFilesOnEditItem({required this.item});
}
