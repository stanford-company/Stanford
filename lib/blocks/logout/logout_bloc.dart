import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/utils/api_service.dart';
import '../../core/utils/shared_prefs_service.dart';
part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final ApiService apiService;

  LogoutBloc(this.apiService, SharedPrefsService sharedPrefsService)
    : super(LogoutInitial()) {
    on<LogoutRequested>((event, emit) async {
      emit(LogoutInProgress());
      try {
        // 1. Call logout API
        final response = await apiService.post(
          'beneficiaries/logout',
          {},
          headers: {'Authorization': 'Bearer ${event.token}'},
        );

        // 2. Check response
        if (response['status'] != 'success') {
          throw Exception(response['message'] ?? 'Logout failed');
        }

        // 3. Clear local storage
        await SharedPrefsService.deleteToken();

        // 4. Emit success
        emit(LogoutSuccess());
      } on Exception catch (e) {
        emit(LogoutFailure(e.toString()));
      } catch (e) {
        emit(LogoutFailure('An unexpected error occurred'));
      }
    });
  }
}
