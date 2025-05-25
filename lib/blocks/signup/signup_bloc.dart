import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/utils/api_service.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final ApiService apiService;

  SignupBloc(this.apiService) : super(SignupInitial()) {
    on<CheckNationalId>((event, emit) async {
      emit(SignupLoading());
      try {
        final response = await apiService.post('beneficiaries/check-id', {
          'national_id': event.nationalId,
        });

        print('API Response: ${response.toString()}');

        // Verify response structure
        if (response['data'] == null) {
          emit(SignupFailure("Invalid server response"));
          return;
        }

        final responseData = response['data'];
        final status = responseData['status']?.toString().toLowerCase();
        final message = responseData['message']?.toString();
        final signUpStatus = responseData['sign_up_status']
            ?.toString()
            .toLowerCase();

        print(
          'Parsed values - status: $status, message: $message, signUpStatus: $signUpStatus',
        );

        if (status == 'success' && signUpStatus == 'yes') {
          // Case 1: User is already registered
          emit(
            SignupSuccess(
              "You are registered in our system. Redirecting to login...",
            ),
          );
        } else if (status == 'success' && signUpStatus == 'no') {
          // Case 2: ID exists but not registered
          print("Nooooooooooooooooooooooooooooooo---------------------------");
        } else if (status == 'no') {
          // Case 3: ID not found or other error
          emit(
            SignupFailure(
              message ?? "ID not found. Please contact Stanford Company.",
            ),
          );
        }
      } catch (e) {
        print('Error in CheckNationalId: $e');
        if (e.toString().contains('Connection') ||
            e.toString().contains('Network')) {
          emit(SignupFailure("ID not found. Please contact Stanford Company."));
        } else {
          emit(SignupFailure("An error occurred. Please try again."));
        }
      }
    });

    on<SubmitFullSignup>((event, emit) async {
      emit(SignupLoading());
      try {
        await apiService.post('beneficiaries/register', {
          "national_id": event.nationalId,
          "email": event.email,
          "password": event.password,
        });
        emit(
          SignupSuccessWithNavigation(
            "Account created successfully. Redirecting to login...",
          ),
        );
      } catch (e) {
        emit(SignupFailure("Signup failed. Try again."));
      }
    });
  }
}
