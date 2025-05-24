part of 'signup_bloc.dart';

abstract class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object?> get props => [];
}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupFailure extends SignupState {
  final String error;
  const SignupFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class SignupSuccess extends SignupState {
  final String message;
  const SignupSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class SignupSuccessWithNavigation extends SignupState {
  final String message;
  const SignupSuccessWithNavigation(this.message);

  @override
  List<Object?> get props => [message];
}

class SignupProceed extends SignupState {
  final String nationalId;
  const SignupProceed(this.nationalId);

  @override
  List<Object?> get props => [nationalId];
}