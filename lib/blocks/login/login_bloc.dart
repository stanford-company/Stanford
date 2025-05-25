import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/utils/api_service.dart';
import '../../core/utils/shared_prefs_service.dart';
import '../../model/user.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ApiService apiService;

  LoginBloc(this.apiService) : super(LoginInitial()) {
    on<LoginSubmitted>((event, emit) async {
      emit(LoginLoading());
      try {
        final response = await apiService.post('beneficiaries/login', {
          'national_id': event.nationalId,
          'password': event.password,
        });

        print('Login API response: $response');

        if (response['status']?.toString().toLowerCase() == 'success') {
          final userData = response['data'] ?? {};
          final token = response['api_token']?.toString() ?? '';
          await SharedPrefsService.saveToken(response['api_token']);

          emit(LoginSuccess(UserModel.fromJson(userData), token: token));
        } else {
          emit(
            LoginFailure(
              response['message'] ?? "Login failed. Please try again.",
            ),
          );
        }
      } catch (e) {
        print('Login error: $e');
        emit(LoginFailure("Network error. Please check your connection."));
      }
    });
  }
}
