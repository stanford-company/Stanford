 import '../../../data/procedures/model/procedures.dart';

sealed class ProcedureState {}

final class ProcedureInitial extends ProcedureState {}

final class ProcedureLoading extends ProcedureState {}

final class ProcedureLoaded extends ProcedureState {
  final List<ProcedureModel> procedures;

  ProcedureLoaded({required this.procedures});
}

final class ProcedureError extends ProcedureState {
  final String message;

  ProcedureError({required this.message});
}
