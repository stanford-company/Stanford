import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medapp/core/utils/setup_service.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../domain/appointments_history/usecase/appointments_usecase.dart';
import '../../../../../data/appointments_history/model/appointments_history.dart';

part 'appointments_state.dart';

class AppointmentsHistoryCubit extends Cubit<AppointmentsHistoryState> {
  AppointmentsHistoryCubit() : super(AppointmentsHistoryInitial());
  List<Appointment> _allAppointments = [];

  Future<void> fetchAppointments() async {
    emit(AppointmentsHistoryLoading());

    final result = await getIt<GetAppointmentsHistoryUsecase>().call();

    result.fold(
      (failure) => emit(
        AppointmentsHistoryError(message: _mapFailureToMessage(failure)),
      ),
      (appointments) {
        _allAppointments = appointments;
        emit(
          // _allAppointments =appointments;
          AppointmentsHistoryLoaded(appointments: appointments, filter: 'All'),
        );
      },
    );
  }

  void getUpcomingAppointments() {
    final now = DateTime.now();
    final upcomingAppointments = _allAppointments.where((appointment) {
      final date = DateTime.parse(appointment.appointmentDate);
      final time = TimeOfDay(
        hour: int.parse(appointment.appointmentTime.split(':')[0]),
        minute: int.parse(appointment.appointmentTime.split(':')[1]),
      );
      final appointmentDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
      return appointmentDateTime.isAfter(now);
    }).toList();
    emit(
      AppointmentsHistoryLoaded(
        appointments: upcomingAppointments,
        filter: 'Upcoming',
      ),
    );
  }

  Appointment getFirstUpcomingAppointments() {
    final now = DateTime.now();
    final upcomingAppointments = _allAppointments.where((appointment) {
      final date = DateTime.parse(appointment.appointmentDate);
      final time = TimeOfDay(
        hour: int.parse(appointment.appointmentTime.split(':')[0]),
        minute: int.parse(appointment.appointmentTime.split(':')[1]),
      );
      final appointmentDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
      return appointmentDateTime.isAfter(now);
    }).toList();
    if (upcomingAppointments.isEmpty) {
      return Appointment(
        medicalEntityName: 'No Upcoming Appointments',
        medicalEntityNameAr: 'لا توجد مواعيد قادمة',
        status: '',
        description: '',
        descriptionAr: '',
        appointmentDate: DateTime.now().toString(),
        appointmentTime: '',
      );
    }
    return upcomingAppointments.first;
  }

  // get String FirstUpcomingAppointments as tommorow or after two days or today
  String getFirstUpcomingAppointmentsString() {
    final now = DateTime.now();
    final firstAppointment = getFirstUpcomingAppointments();
    final date = DateTime.parse(firstAppointment.appointmentDate);
    final difference = date.difference(now).inDays;

    if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Tomorrow';
    } else {
      return 'After $difference days';
    }
  }

  void getPreviousAppointments() {
    final now = DateTime.now();
    final previousAppointments = _allAppointments.where((appointment) {
      final date = DateTime.parse(appointment.appointmentDate);
      final time = TimeOfDay(
        hour: int.parse(appointment.appointmentTime.split(':')[0]),
        minute: int.parse(appointment.appointmentTime.split(':')[1]),
      );
      final appointmentDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
      return appointmentDateTime.isBefore(now);
    }).toList();
    emit(
      AppointmentsHistoryLoaded(
        appointments: previousAppointments,
        filter: 'Previous',
      ),
    );
  }

  void getAllAppointments() {
    emit(
      AppointmentsHistoryLoaded(appointments: _allAppointments, filter: 'All'),
    );
  }
  //filter appointments by filterKeys

  void getAcceptedAppointments() {
    final acceptedAppointments = _allAppointments.where((appointment) {
      return appointment.status == 'confirmed';
    }).toList();
    emit(
      AppointmentsHistoryLoaded(
        appointments: acceptedAppointments,
        filter: 'Accepted',
      ),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return failure.message;
    }
    return "An unexpected error occurred";
  }
}
