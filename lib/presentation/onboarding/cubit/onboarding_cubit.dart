import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medapp/core/utils/shared_prefs_service.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial());

  int currentIndex = 0;

  void nextPage() {
    if (currentIndex < 2) {
      currentIndex++;
      emit(OnboardingPageChanged(currentIndex));
    } else {
      completeOnboarding();
    }
  }

  void previousPage() {
    if (currentIndex > 0) {
      currentIndex--;
      emit(OnboardingPageChanged(currentIndex));
    }
  }

  void skipOnboarding() {
    emit(OnboardingSkipped());
    _saveOnboardingStatus();
  }

  void completeOnboarding() {
    emit(OnboardingCompleted());
    _saveOnboardingStatus();
  }

  void _saveOnboardingStatus() async {
    await SharedPrefsService.setOnboardingCompleted(true);
  }

  void goToPage(int index) {
    currentIndex = index;
    emit(OnboardingPageChanged(currentIndex));
  }
}
