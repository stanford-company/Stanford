import 'package:bloc/bloc.dart';
import 'package:medapp/presentation/auth/bloc/register_state.dart';
import '../../../core/utils/setup_service.dart';
import '../../../domain/auth/usecase/register_usecase.dart';
import '../../../data/auth/model/login.dart'; // UserParams

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future<void> register({
    required String nationalId,
    required String email,
    required String password,
  }) async {
    emit(RegisterLoading());

    final result = await getIt<RegisterUsecase>().call(
      params: {
        'national_id': nationalId,
        'email': email,
        'password': password,
      },
    );
    result.fold(
          (failure) => emit(RegisterFailure(failure.message)),
          (user) => emit(RegisterSuccess(user)),
    );
  }
}
