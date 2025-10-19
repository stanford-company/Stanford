part of 'onboarding_cubit.dart';

abstract class OnboardingState {}

class OnboardingInitial extends OnboardingState {}

class OnboardingPageChanged extends OnboardingState {
  final int currentIndex;

  OnboardingPageChanged(this.currentIndex);
}

class OnboardingCompleted extends OnboardingState {}

class OnboardingSkipped extends OnboardingState {}
