import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medapp/domain/auth/usecase/get_profile_usecase.dart';
import 'package:meta/meta.dart';

import '../../../core/utils/setup_service.dart';
import '../../../data/auth/model/profile.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  Future<void> getProfile() async {
    emit(ProfileLoadingState());
    var result = await getIt<GetProfileUsecase>().call();
    result.fold(
      (failure) {
        print(failure.message);
        emit(ProfileFailureState());
      },
      (profile) {
        emit(ProfileLoadedState(profile));
      },
    );
  }
}
