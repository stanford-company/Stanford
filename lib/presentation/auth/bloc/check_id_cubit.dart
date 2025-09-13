import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
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
      emit(CheckIdFailure("Your national id dosen't exist in our system , please connect with stanford company to register"));
    }, (status) async {
      emit(CheckIdLoaded(status));
    });

    result.fold(
          (failure) {
        String errorMessage;

        if (failure.message.contains('401')) {
          // 🔁 Localized message
          errorMessage = tr('invalid_national_id_or_password');
        } else {
          errorMessage = tr('general_error');
        }

        emit(CheckIdFailure(errorMessage));
      },
          (userParams) {
        emit(CheckIdLoaded(userParams));
      },
    );
  }


}
