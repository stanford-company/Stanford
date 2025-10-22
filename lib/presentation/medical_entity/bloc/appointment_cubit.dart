import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:medapp/domain/medical_entity/usecase/set_appointment.dart';
import '../../../core/utils/setup_service.dart';
import '../../../data/medical_entity/model/appointment_params.dart';
import '../../appointments_history/bloc/appointments_cubit.dart';
import '../../../data/appointments_history/model/appointments_history.dart'; // ✅ Appointment model import
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
    final appointmentData = state.params.toJson();
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

  // ✅ Modified version with context and local Appointment creation
  Future<void> setAppointment(final int id, BuildContext context,
      {String? medicalEntityName, String? medicalEntityNameAr}) async {
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

    result.fold(
          (failure) => emit(state.copyWith(isLoading: false)),
          (response) {
        // ✅ Create a new appointment using real medical entity name
        final newAppointment = Appointment(
          medicalEntityName: medicalEntityName ?? 'Unknown',
          medicalEntityNameAr: medicalEntityNameAr ?? 'غير معروف',
          status: 'pending',
          description: state.params.details ?? '',
          descriptionAr: state.params.details ?? '',
          appointmentDate:
          state.params.date!.toIso8601String().split('T').first,
          appointmentTime:
          '${state.params.time!.hour.toString().padLeft(2, '0')}:${state.params.time!.minute.toString().padLeft(2, '0')}',
        );

        try {
          context
              .read<AppointmentsHistoryCubit>()
              .addNewAppointment(newAppointment);
        } catch (e) {
          print('⚠️ Could not find AppointmentsHistoryCubit in context: $e');
        }

        emit(state.copyWith(isSuccess: true));
      },
    );
  }

}
