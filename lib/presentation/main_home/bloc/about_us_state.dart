part of 'about_us_cubit.dart';

@immutable
sealed class AboutUsState {}

final class AboutUsInitial extends AboutUsState {}

final class AboutUsLoadingState extends AboutUsState {}

final class AboutUsLoadedState extends AboutUsState {
  final AboutUsModel aboutUsModel;

  AboutUsLoadedState(this.aboutUsModel);
}

final class AboutUsFailureState extends AboutUsState {}
