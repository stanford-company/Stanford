import 'package:bloc/bloc.dart';
import 'package:medapp/domain/auth/usecase/check_id_usecase.dart';
import 'package:meta/meta.dart';

 import '../../../core/utils/setup_service.dart';
import '../../../data/auth/model/login.dart';
import '../../../domain/auth/usecase/login_usecase.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login({
    required String nationalId,
    required String password,
  }) async {
    emit(LoginLoading());

    // Build your UserParams or LoginRequest here based on your data models
    // For example, if you want to build UserParams:
    final userParams = UserParams(
      data: UserData(
        id: 0,
        fullName: '',
        email: '',
        nationalId: nationalId,
        phone: '',
        gender: '',
        signUpStatus: '',
        isActive: 1,
      ),
      status: '',
      apiToken: '',
    );

    var result = await getIt<LoginUsecase>().call(params: userParams);
    result.fold((failure) {
      print(failure.message);
      emit(LoginFailure(failure.message));
    }, (status) {
      emit(LoginLoaded(status));
    });
  }
}

