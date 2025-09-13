part of 'appointments_cubit.dart';

abstract class AppointmentsHistoryState {
  const AppointmentsHistoryState();
}

class AppointmentsHistoryInitial extends AppointmentsHistoryState {}

class AppointmentsHistoryLoading extends AppointmentsHistoryState {}

class AppointmentsHistoryLoaded extends AppointmentsHistoryState {
  final List<Appointment> appointments;
  final String filter;

  const AppointmentsHistoryLoaded({
    required this.appointments,
    required this.filter,
  });
}

class AppointmentsHistoryError extends AppointmentsHistoryState {
  final String message;

  const AppointmentsHistoryError({required this.message});
}
