import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/setup_service.dart';
import '../../../domain/auth/usecase/logout_usecase.dart';
import '../../../data/auth/model/logout.dart'; // ✅ Import here instead

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit() : super(LogoutInitial());

  Future<void> logout() async {
    emit(LogoutLoading());

    final result = await getIt<LogoutUsecase>().call();

    result.fold(
      (failure) => emit(LogoutFailure(failure.message)),
      (logoutModel) => emit(LogoutLoaded(logoutModel)),
    );
  }
}
