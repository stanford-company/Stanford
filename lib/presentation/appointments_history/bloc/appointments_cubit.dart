import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      return appointmentDateTime.isAfter(now) &&
          appointment.status == 'confirmed';
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

    // Sort appointments by date and time to get the nearest one
    upcomingAppointments.sort((a, b) {
      final dateA = DateTime.parse(a.appointmentDate);
      final timeA = TimeOfDay(
        hour: int.parse(a.appointmentTime.split(':')[0]),
        minute: int.parse(a.appointmentTime.split(':')[1]),
      );
      final appointmentDateTimeA = DateTime(
        dateA.year,
        dateA.month,
        dateA.day,
        timeA.hour,
        timeA.minute,
      );

      final dateB = DateTime.parse(b.appointmentDate);
      final timeB = TimeOfDay(
        hour: int.parse(b.appointmentTime.split(':')[0]),
        minute: int.parse(b.appointmentTime.split(':')[1]),
      );
      final appointmentDateTimeB = DateTime(
        dateB.year,
        dateB.month,
        dateB.day,
        timeB.hour,
        timeB.minute,
      );

      return appointmentDateTimeA.compareTo(appointmentDateTimeB);
    });

    return upcomingAppointments.first;
  }

  // get String FirstUpcomingAppointments as tommorow or after two days or today
  String getFirstUpcomingAppointmentsString(BuildContext context) {
    final now = DateTime.now();
    final firstAppointment = getFirstUpcomingAppointments();
    final date = DateTime.parse(firstAppointment.appointmentDate);
    final difference = date.difference(now).inDays;

    if (difference == 0) {
      return 'today'.tr();
    } else if (difference == 1) {
      return 'tomorrow'.tr();
    } else {
      return tr('after_days', args: [difference.toString()]);
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

  void getPendingAppointments() {
    final pendingAppointments = _allAppointments.where((appointment) {
      return appointment.status == 'pending';
    }).toList();
    emit(
      AppointmentsHistoryLoaded(
        appointments: pendingAppointments,
        filter: 'Pending',
      ),
    );
  }

  void getConfirmedAppointments() {
    final confirmedAppointments = _allAppointments.where((appointment) {
      return appointment.status == 'confirmed';
    }).toList();
    emit(
      AppointmentsHistoryLoaded(
        appointments: confirmedAppointments,
        filter: 'Confirmed',
      ),
    );
  }

  void getCompletedAppointments() {
    final completedAppointments = _allAppointments.where((appointment) {
      return appointment.status == 'completed';
    }).toList();
    emit(
      AppointmentsHistoryLoaded(
        appointments: completedAppointments,
        filter: 'Completed',
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
