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

    final result = await getIt<LoginUsecase>().call(params: {
      'national_id': nationalId,
      'password': password,
    });

    result.fold(
          (failure) {
        emit(LoginFailure(failure.message));
      },
          (userParams) {
        emit(LoginLoaded(userParams));
      },
    );
  }

}

