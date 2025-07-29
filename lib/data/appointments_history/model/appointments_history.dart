class Appointment {
  final String medicalEntityName;
  final String medicalEntityNameAr;
  final String status;
  final String? description;
  final String? descriptionAr;
  final String appointmentDate;
  final String appointmentTime;

  Appointment({
    required this.medicalEntityName,
    required this.medicalEntityNameAr,
    required this.status,
    this.description,
    this.descriptionAr,
    required this.appointmentDate,
    required this.appointmentTime,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    final medicalEntity = json['medical_entity'];

    return Appointment(
      medicalEntityName: medicalEntity['name'] ?? '',
      medicalEntityNameAr: medicalEntity['name_ar'] ?? '',
      status: json['status'] ?? '',
      description: medicalEntity['description'],
      descriptionAr: medicalEntity['description_ar'],
      appointmentDate: json['appointment_date'] ?? '',
      appointmentTime: json['appointment_time'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'medical_entity_name': medicalEntityName,
      'medical_entity_name_ar': medicalEntityNameAr,
      'status': status,
      'description': description,
      'description_ar': descriptionAr,
      'appointment_date': appointmentDate,
      'appointment_time': appointmentTime,
    };
  }
}
