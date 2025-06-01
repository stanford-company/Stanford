part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginLoaded extends LoginState {
  final UserParams userParams;

  LoginLoaded(this.userParams);
}

final class LoginFailure extends LoginState {
  final String message;

  LoginFailure(this.message);
}
