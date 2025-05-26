import 'package:bloc/bloc.dart';
import 'package:medapp/data/auth/model/check_id.dart';
import 'package:medapp/domain/auth/usecase/check_id_usecase.dart';
import 'package:meta/meta.dart';

import '../../../core/utils/setup_service.dart';

part 'check_id_state.dart';

class CheckIdCubit extends Cubit<CheckIdState> {
  CheckIdCubit() : super(CheckIdInitial());

  Future<void> checkID({required String nationalId}) async {
    emit(CheckIdLoading());
    var result = await getIt<CheckIdUsecase>().call(params: nationalId);
    result.fold((failure) {
      print(failure.message);
      emit(CheckIdFailure(failure.message));
    }, (status) async {
      emit(CheckIdLoaded(status));
    });
  }
}
