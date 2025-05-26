class CheckIdModel {
  final String status;
  final String message;
  final String signUpStatus;

  CheckIdModel({
    required this.status,
    required this.message,
    required this.signUpStatus,
  });

  factory CheckIdModel.fromJson(Map<String, dynamic> json) {
    return CheckIdModel(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      signUpStatus: json['sign_up_status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'sign_up_status': signUpStatus,
    };
  }
}
