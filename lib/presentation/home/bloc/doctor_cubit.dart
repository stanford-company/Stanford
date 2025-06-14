import 'package:bloc/bloc.dart';
import 'package:medapp/domain/medical_entity/usecase/get_medical_doctors.dart';
import 'package:meta/meta.dart';

import '../../../core/utils/setup_service.dart';
import '../../../data/medical_entity/model/medical_doctor.dart';
import '../../../domain/city/usecase/city_usecase.dart';

part 'doctor_state.dart';

class DoctorCubit extends Cubit<DoctorState> {
  DoctorCubit() : super(DoctorInitial());

  Future<void> getDoctor() async {
    emit(DoctorLoading());
    var result = await getIt<GetMedicalDoctorsUseCase>().call();
    result.fold(
      (failure) {
        print(failure.message);
        emit(DoctorFailure());
      },
      (doctors) {
        emit(DoctorLoaded(doctors));
      },
    );
  }
}
