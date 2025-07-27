part of 'appointments_cubit.dart';

abstract class AppointmentsHistoryState extends Equatable {
  const AppointmentsHistoryState();

  @override
  List<Object?> get props => [];
}

class AppointmentsHistoryInitial extends AppointmentsHistoryState {}

class AppointmentsHistoryLoading extends AppointmentsHistoryState {}

class AppointmentsHistoryLoaded extends AppointmentsHistoryState {
  final List<Appointment> appointments;

  const AppointmentsHistoryLoaded({required this.appointments});

  @override
  List<Object?> get props => [appointments];
}

class AppointmentsHistoryError extends AppointmentsHistoryState {
  final String message;

  const AppointmentsHistoryError({required this.message});

  @override
  List<Object?> get props => [message];
}
