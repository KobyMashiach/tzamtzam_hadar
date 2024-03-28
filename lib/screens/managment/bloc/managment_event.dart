part of 'managment_bloc.dart';

@immutable
abstract class ManagmentEvent {}

class ManagmentEventInit extends ManagmentEvent {}

class ManagmentEventOpenDialog extends ManagmentEvent {
  final int index;

  ManagmentEventOpenDialog(this.index);
}
