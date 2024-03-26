import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'managment_event.dart';
part 'managment_state.dart';

class ManagmentBloc extends Bloc<ManagmentEvent, ManagmentState> {
  ManagmentBloc() : super(ManagmentInitial()) {
    on<ManagmentEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
