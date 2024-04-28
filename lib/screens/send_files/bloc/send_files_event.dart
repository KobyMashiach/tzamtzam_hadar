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

class SendFilesOnLoadingScreen extends SendFilesEvent {}

class SendFilesOnDoneLoading extends SendFilesEvent {}

class SendFilesOnSaveEditItem extends SendFilesEvent {
  final String title;
  final String description;
  final String type;
  final String networkUrl;
  final XFile image;
  final XFile? qrImage;
  final String oldTitle;
  final bool emailLink;

  SendFilesOnSaveEditItem({
    required this.title,
    required this.description,
    required this.type,
    required this.networkUrl,
    required this.image,
    required this.qrImage,
    required this.oldTitle,
    required this.emailLink,
  });
}
