part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object?> get props => [];
}

class CheckNationalId extends SignupEvent {
  final String nationalId;

  const CheckNationalId(this.nationalId);

  @override
  List<Object?> get props => [nationalId];
}

class SubmitFullSignup extends SignupEvent {
  final String nationalId;
  final String email;
  final String password;

  const SubmitFullSignup({
    required this.nationalId,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [nationalId, email, password];
}
