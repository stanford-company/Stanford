import 'package:flutter_bloc/flutter_bloc.dart';

// Event
abstract class RememberMeEvent {}

class ToggleRememberMe extends RememberMeEvent {
  final bool value;
  ToggleRememberMe(this.value);
}

// State
class RememberMeState {
  final bool isChecked;
  RememberMeState({required this.isChecked});
}

// Bloc
class RememberMeBloc extends Bloc<RememberMeEvent, RememberMeState> {
  RememberMeBloc() : super(RememberMeState(isChecked: false)) {
    on<ToggleRememberMe>((event, emit) {
      emit(RememberMeState(isChecked: event.value));
    });
  }
}
