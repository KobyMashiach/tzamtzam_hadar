part of 'managment_bloc.dart';

@immutable
abstract class ManagmentEvent {}

class ManagmentEventInit extends ManagmentEvent {}

class ManagmentEventOpenDialog extends ManagmentEvent {
  final int index;

  ManagmentEventOpenDialog(this.index);
}

class ManagmentEventClearOrders extends ManagmentEvent {}

class ManagmentEventAddNewSendFilesItem extends ManagmentEvent {
  final String title;
  final String description;
  final String type;
  final String networkUrl;
  final XFile image;
  final XFile? qrImage;
  final bool emailLink;

  ManagmentEventAddNewSendFilesItem({
    required this.title,
    required this.description,
    required this.type,
    required this.networkUrl,
    required this.image,
    required this.qrImage,
    required this.emailLink,
  });
}
