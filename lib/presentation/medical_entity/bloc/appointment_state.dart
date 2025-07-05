import '../../../data/medical_entity/model/appointment_params.dart';

class AppointmentState {
  final AppointmentParams params;
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;

  AppointmentState({
    AppointmentParams? params,
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
  }) : params = params ?? AppointmentParams();

  AppointmentState copyWith({
    AppointmentParams? params,
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return AppointmentState(
      params: params ?? this.params,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
    );
  }
}
