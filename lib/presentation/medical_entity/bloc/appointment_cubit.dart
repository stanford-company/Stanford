import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medapp/domain/medical_entity/usecase/set_appointment.dart';

import '../../../core/utils/setup_service.dart';
import '../../../data/medical_entity/model/appointment_params.dart';
import 'appointment_state.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  AppointmentCubit() : super(AppointmentState());

  void setPhone(String value) =>
      emit(state.copyWith(params: state.params.copyWith(phone: value)));

  void setDetails(String value) =>
      emit(state.copyWith(params: state.params.copyWith(details: value)));

  void setDate(DateTime value) =>
      emit(state.copyWith(params: state.params.copyWith(date: value)));

  void setTime(DateTime value) =>
      emit(state.copyWith(params: state.params.copyWith(time: value)));

  Future<void> submitAppointment() async {
    emit(state.copyWith(isLoading: true));

    // Convert params to JSON
    final appointmentData = state.params.toJson();

    // TODO: Replace this with your API call:
    await Future.delayed(const Duration(seconds: 2));

    print('Sending to API: $appointmentData');

    emit(state.copyWith(isLoading: false));
  }

  bool isFormValid() {
    return state.params.phone != null &&
        state.params.details != null &&
        state.params.date != null &&
        state.params.time != null;
  }

  Future<void> setAppointment(final int id) async {
    emit(state.copyWith(isLoading: true));

    var result = await getIt<SetAppointmentUseCase>().call(
      params: AppointmentParams(
        medicalId: id,
        phone: state.params.phone,
        details: state.params.details,
        date: state.params.date,
        time: state.params.time,
      ),
    );

    result.fold((failure) => emit(state.copyWith(isLoading: false)), (
      entities,
    ) {
      emit(state.copyWith(isSuccess: true));
    });
  }
}
