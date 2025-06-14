import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/utils/setup_service.dart';
import '../../../data/medical_entity/model/medical_doctor.dart';
import '../../../domain/medical_entity/usecase/get_medical_centers.dart';

part 'center_state.dart';

class CenterCubit extends Cubit<CenterState> {
  CenterCubit() : super(CenterInitial());

  Future<void> getCenter() async {
    emit(CenterLoading());
    var result = await getIt<GetMedicalCentersUseCase>().call();
    result.fold(
      (failure) {
        print(failure.message);
        emit(CenterFailure());
      },
      (centers) {
        emit(CenterLoaded(centers));
      },
    );
  }
}
