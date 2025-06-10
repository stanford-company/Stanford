part of 'ads_cubit.dart';

@immutable
sealed class AdsState {}

final class AdsInitial extends AdsState {}

final class AdsLoading extends AdsState {}

final class AdsLoaded extends AdsState {
  final AdsModel ads;

  AdsLoaded({required this.ads});
}

final class AdsError extends AdsState {
  final String message;

  AdsError({required this.message});
}
