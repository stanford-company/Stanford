part of 'check_id_cubit.dart';

@immutable
sealed class CheckIdState {}

final class CheckIdInitial extends CheckIdState {}
final class CheckIdLoading extends CheckIdState {}
final class CheckIdLoaded extends CheckIdState {
  final CheckIdModel checkIdModel;

  CheckIdLoaded(this.checkIdModel);
}
final class CheckIdFailure extends CheckIdState {
  final String message;

  CheckIdFailure(this.message);
}
