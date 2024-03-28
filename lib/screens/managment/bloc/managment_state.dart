part of 'managment_bloc.dart';

@immutable
abstract class ManagmentState {
  final List<String> managmentList;

  ManagmentState({required this.managmentList});
}

final class ManagmentStateInitial extends ManagmentState {
  ManagmentStateInitial({required super.managmentList});
}

final class ManagmentStateLoading extends ManagmentState {
  ManagmentStateLoading({required super.managmentList});
}

@immutable
abstract class ManagmentNavigationState extends ManagmentState {
  ManagmentNavigationState({required super.managmentList});
}

final class ManagmentNavigationOpenSendFilesDialog
    extends ManagmentNavigationState {
  final int index;
  ManagmentNavigationOpenSendFilesDialog(
      {required this.index, required super.managmentList});
}
