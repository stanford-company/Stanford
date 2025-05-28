import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:medapp/domain/auth/usecase/logout_usecase.dart';

import '../../data/auth/repository/auth_repo_imp.dart';
import '../../data/auth/service/auth_service.dart';
import '../../domain/auth/repository/auth_repo.dart';
import '../../domain/auth/usecase/check_id_usecase.dart';
import '../../domain/auth/usecase/login_usecase.dart';
import '../services/api_service.dart';

final GetIt getIt = GetIt.instance;
void setUpServiceLocator() {
  getIt.registerSingleton<ApiService>(
    ApiService(
      Dio(),
    ),

  );

  //service
  getIt.registerSingleton<AuthService>(AuthServiceImp(getIt.get<ApiService>()));

  //repository
  getIt.registerSingleton<AuthRepository>(AuthRepositoryImp());

  //usecase
  getIt.registerSingleton<CheckIdUsecase>(CheckIdUsecase());
  getIt.registerSingleton<LoginUsecase>(LoginUsecase());
  getIt.registerSingleton<LogoutUsecase>(LogoutUsecase());


}