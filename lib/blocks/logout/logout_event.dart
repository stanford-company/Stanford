part of 'logout_bloc.dart';

abstract class LogoutEvent extends Equatable {
  const LogoutEvent();

  @override
  List<Object?> get props => [];
}

class LogoutRequested extends LogoutEvent {
  final String token;

  const LogoutRequested(this.token);

  @override
  List<Object?> get props => [token];
}