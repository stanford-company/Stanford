import 'package:bloc/bloc.dart';
import '../../../core/utils/setup_service.dart';
import '../../../domain/auth/usecase/forgot_password_usecase.dart';
 import 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(ForgotPasswordInitial());

  Future<void> forgotPassword({
    required String nationalId,
    required String confirmPassword,
    required String password,
  }) async {
    emit(ForgotPasswordLoading());

    final result = await getIt<ForgotPasswordUsecase>().call(
      params: {
        'national_id': nationalId,
        'password_confirmation': confirmPassword,
        'password': password,
      },
    );

    result.fold(
          (failure) => emit(ForgotPasswordFailure(failure.message)),
          (user) => emit(ForgotPasswordSuccess(user)),
    );
  }
}
