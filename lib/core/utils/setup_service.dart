import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:medapp/data/category/repository/category_repo_imp.dart';
import 'package:medapp/data/category/service/category.dart';
import 'package:medapp/data/medical_entity/repository/medical_enitity_repo_imp.dart';
import 'package:medapp/data/medical_entity/service/medical_entity.dart';
import 'package:medapp/domain/category/repository/category_repo.dart';
import 'package:medapp/data/auth/model/register.dart';
import 'package:medapp/domain/auth/usecase/logout_usecase.dart';
import 'package:medapp/domain/medical_entity/repository/entity_repo.dart';
import 'package:medapp/domain/medical_entity/usecase/entity_usecase.dart';

import '../../data/auth/repository/auth_repo_imp.dart';
import '../../data/auth/service/auth_service.dart';
import '../../data/cities/repository/city_repo_imp.dart';
import '../../data/cities/service/city.dart';
import '../../domain/auth/repository/auth_repo.dart';
import '../../domain/auth/usecase/check_id_usecase.dart';
import '../../domain/auth/usecase/forgot_password_usecase.dart';
import '../../domain/auth/usecase/login_usecase.dart';
import '../../domain/auth/usecase/register_usecase.dart';
import '../../domain/category/usecase/category_usecase.dart';
import '../../domain/city/repository/city_repo.dart';
import '../../domain/city/usecase/city_usecase.dart';
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
  getIt.registerSingleton<CategoryService>(CategoryServiceImp(getIt.get<ApiService>()));
  getIt.registerSingleton<CityService>(CityServiceImp(getIt.get<ApiService>()));
  getIt.registerSingleton<MedicalEntityService>(MedicalEntityServiceImp(getIt.get<ApiService>()));



  //repository
  getIt.registerSingleton<AuthRepository>(AuthRepositoryImp());
  getIt.registerSingleton<CategoryRepository>(CategoryRepositoryImp());
  getIt.registerSingleton<CityRepository>(CityRepositoryImp());
  getIt.registerSingleton<EntityRepository>(EntityRepositoryImp());



  //usecase
  getIt.registerSingleton<CheckIdUsecase>(CheckIdUsecase());
  getIt.registerSingleton<RegisterUsecase>(RegisterUsecase());
  getIt.registerSingleton<ForgotPasswordUsecase>(ForgotPasswordUsecase());
  getIt.registerSingleton<LoginUsecase>(LoginUsecase());
  getIt.registerSingleton<LogoutUsecase>(LogoutUsecase());
  getIt.registerSingleton<GetCategoriesUsecase>(GetCategoriesUsecase());
  getIt.registerSingleton<GetCitiesUsecase>(GetCitiesUsecase());
  getIt.registerSingleton<GetEntitiesUsecase>(GetEntitiesUsecase());
}