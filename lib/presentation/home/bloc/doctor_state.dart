part of 'doctor_cubit.dart';

@immutable
sealed class DoctorState {}

final class DoctorInitial extends DoctorState {}

final class DoctorLoading extends DoctorState {}

final class DoctorLoaded extends DoctorState {
  final List<MedicalModel> medicalDoctors;

  DoctorLoaded(this.medicalDoctors);
}

final class DoctorFailure extends DoctorState {}
