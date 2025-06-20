part of 'profile_cubit.dart';

@immutable
abstract class ProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileLoadingState extends ProfileState {}

final class ProfileLoadedState extends ProfileState {
  final ProfileModel profile;

  ProfileLoadedState(this.profile);

  @override
  List<Object?> get props => [profile];
}

final class ProfileFailureState extends ProfileState {}
