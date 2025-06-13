part of 'center_cubit.dart';

@immutable
sealed class CenterState {}

final class CenterInitial extends CenterState {}

final class CenterLoading extends CenterState {}

final class CenterLoaded extends CenterState {
  final List<MedicalModel> medicalCenters;

  CenterLoaded(this.medicalCenters);
}

final class CenterFailure extends CenterState {}
