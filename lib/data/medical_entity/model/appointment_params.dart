class AppointmentParams {
  final int? medicalId;
  final String? fullName;
  final String? phone;
  final String? email;
  final String? details;
  final DateTime? date;
  final DateTime? time;

  AppointmentParams({
    this.fullName,
    this.phone,
    this.email,
    this.details,
    this.date,
    this.time,
    this.medicalId,
  });

  AppointmentParams copyWith({
    String? fullName,
    String? phone,
    String? email,
    String? details,
    DateTime? date,
    DateTime? time,
  }) {
    return AppointmentParams(
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      details: details ?? this.details,
      date: date ?? this.date,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toJson() => {
    'medical_entity_id': medicalId,

    'phone': phone,
    'email': email,
    'notes': details,
    'appointment_date': date?.toString().split(' ')[0],
    'appointment_time': time?.toString().split(' ')[1],
  };
}
