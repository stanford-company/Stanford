import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../domain/appointments_history/usecase/appointments_usecase.dart';
import '../../../../../data/appointments_history/model/appointments_history.dart';

part 'appointments_state.dart';

class AppointmentsHistoryCubit extends Cubit<AppointmentsHistoryState> {
  final GetAppointmentsHistoryUsecase getAppointmentsHistoryUsecase;

  AppointmentsHistoryCubit({required this.getAppointmentsHistoryUsecase})
      : super(AppointmentsHistoryInitial());

  Future<void> fetchAppointments() async {
    emit(AppointmentsHistoryLoading());

    final result = await getAppointmentsHistoryUsecase();

    result.fold(
          (failure) =>
          emit(AppointmentsHistoryError(message: _mapFailureToMessage(failure))),
          (appointments) =>
          emit(AppointmentsHistoryLoaded(appointments: appointments)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return failure.message;
    }
    return "An unexpected error occurred";
  }
}
