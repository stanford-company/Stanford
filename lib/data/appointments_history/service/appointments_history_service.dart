import 'package:medapp/core/services/api_service.dart';

import '../model/appointments_history.dart';

abstract class AppointmentService {
  Future<List<Appointment>> getAppointments();
}

class AppointmentServiceImp extends AppointmentService {
  final ApiService apiService;

  AppointmentServiceImp(this.apiService);

  @override
  Future<List<Appointment>> getAppointments() async {
    final data = await apiService.get(endPoint: "appointments/get");

    print(data); // Optional: For debugging

    List<Appointment> appointments = [];
    for (var item in data['data']) {
      appointments.add(Appointment.fromJson(item));
    }

    return appointments;
  }
}
