import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:medapp/core/utils/shared_prefs_service.dart';
import 'package:medapp/core/constants/const.dart';
import 'package:meta/meta.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../core/utils/setup_service.dart';
import '../../../data/auth/model/login.dart';
import '../../../domain/auth/usecase/login_usecase.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login({
    required String nationalId,
    required String password,
    bool rememberMe = false,
  }) async {
    emit(LoginLoading());

    final result = await getIt<LoginUsecase>().call(
      params: {'national_id': nationalId, 'password': password},
    );

    result.fold(
      (failure) {
        String errorMessage;

        if (failure.message.contains('401')) {
          // 🔁 Localized message
          errorMessage = tr('invalid_national_id_or_password');
        } else {
          errorMessage = tr('general_error');
        }

        emit(LoginFailure(errorMessage));
      },
      (userParams) {
        if (rememberMe) {
          SharedPrefsService.saveData(key: TextConst.rememberMe, value: true);
          SharedPrefsService.saveData(key: "national_id", value: nationalId);
          SharedPrefsService.saveData(key: "password", value: password);
        } else {
          SharedPrefsService.removeData(key: TextConst.rememberMe);
          SharedPrefsService.removeData(key: "national_id");
          SharedPrefsService.removeData(key: "password");
        }
        emit(LoginLoaded(userParams));
      },
    );
  }

  // remmber me
  Future<void> checkRememberMe() async {
    final rememberMe =
        await SharedPrefsService.getData(key: TextConst.rememberMe) ?? false;
    emit(RememberState(rememberMe));
  }
}
