part of 'logout_cubit.dart';

abstract class LogoutState {}

class LogoutInitial extends LogoutState {}

class LogoutLoading extends LogoutState {}

class LogoutLoaded extends LogoutState {
  final LogoutModel logoutModel;
  LogoutLoaded(this.logoutModel);
}

class LogoutFailure extends LogoutState {
  final String message;
  LogoutFailure(this.message);
}
