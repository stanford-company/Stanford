import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:medapp/data/ads/service/ads_service.dart';
import 'package:medapp/data/app/repository/app_repo_imp.dart';
import 'package:medapp/data/app/service/app_service.dart';
import 'package:medapp/data/category/repository/category_repo_imp.dart';
import 'package:medapp/data/category/service/category.dart';
import 'package:medapp/data/medical_entity/repository/medical_enitity_repo_imp.dart';
import 'package:medapp/data/medical_entity/service/medical_service.dart';
import 'package:medapp/data/store/repository/store_repo_imp.dart';
import 'package:medapp/data/store/service/store.dart';
import 'package:medapp/domain/app/repository/app_repo.dart';
import 'package:medapp/domain/category/repository/category_repo.dart';
import 'package:medapp/domain/auth/usecase/logout_usecase.dart';
import 'package:medapp/domain/medical_entity/repository/medical_repo.dart';
import 'package:medapp/domain/medical_entity/usecase/entity_usecase.dart';
import 'package:medapp/domain/store/repository/store_repo.dart';

import '../../data/ads/repository/ads_repo_imp.dart';
import '../../data/auth/repository/auth_repo_imp.dart';
import '../../data/auth/service/auth_service.dart';
import '../../data/cities/repository/city_repo_imp.dart';
import '../../data/cities/service/city.dart';
import '../../data/suggestions/repository/suggestions_repo_imp.dart';
import '../../data/suggestions/service/suggestions.dart';
import '../../domain/ads/repository/ads.repo.dart';
import '../../domain/ads/usecase/ads_usecase.dart';
import '../../domain/app/usecase/get_about_us_usecase.dart';
import '../../domain/app/usecase/procedures_usecase.dart';
import '../../domain/auth/repository/auth_repo.dart';
import '../../domain/auth/usecase/check_id_usecase.dart';
import '../../domain/auth/usecase/forgot_password_usecase.dart';
import '../../domain/auth/usecase/get_profile_usecase.dart';
import '../../domain/auth/usecase/login_usecase.dart';
import '../../domain/auth/usecase/register_usecase.dart';
import '../../domain/category/usecase/category_usecase.dart';
import '../../domain/city/repository/city_repo.dart';
import '../../domain/city/usecase/city_usecase.dart';
import '../../domain/medical_entity/usecase/get_medical_centers.dart';
import '../../domain/medical_entity/usecase/get_medical_doctors.dart';
import '../../domain/medical_entity/usecase/medical_search.dart';
import '../../domain/medical_entity/usecase/set_appointment.dart';
import '../../domain/suggestions/repository/suggestions_repo.dart';
import '../../domain/suggestions/usecase/suggestions_usecase.dart';
import '../../domain/store/usecase/get_supplies_usecase.dart';
import '../services/api_service.dart';

final GetIt getIt = GetIt.instance;
void setUpServiceLocator() {
  getIt.registerSingleton<ApiService>(ApiService(Dio()));

  //service
  getIt.registerSingleton<AuthService>(AuthServiceImp(getIt.get<ApiService>()));
  getIt.registerSingleton<CategoryService>(
    CategoryServiceImp(getIt.get<ApiService>()),
  );
  getIt.registerSingleton<CityService>(CityServiceImp(getIt.get<ApiService>()));
  getIt.registerSingleton<MedicalService>(
    MedicalServiceImp(getIt.get<ApiService>()),
  );
  getIt.registerSingleton<StoreService>(
    StoreServiceImp(getIt.get<ApiService>()),
  );

  //repository
  getIt.registerSingleton<AuthRepository>(AuthRepositoryImp());
  getIt.registerSingleton<CategoryRepository>(CategoryRepositoryImp());
  getIt.registerSingleton<CityRepository>(CityRepositoryImp());
  getIt.registerSingleton<MedicalRepository>(MedicalRepositoryImp());
  getIt.registerSingleton<StoreRepository>(StoreRepositoryImp());

  //usecase
  getIt.registerSingleton<CheckIdUsecase>(CheckIdUsecase());
  getIt.registerSingleton<RegisterUsecase>(RegisterUsecase());
  getIt.registerSingleton<ForgotPasswordUsecase>(ForgotPasswordUsecase());
  getIt.registerSingleton<LoginUsecase>(LoginUsecase());
  getIt.registerSingleton<LogoutUsecase>(LogoutUsecase());
  getIt.registerSingleton<GetCategoriesUsecase>(GetCategoriesUsecase());
  getIt.registerSingleton<GetCitiesUsecase>(GetCitiesUsecase());
  getIt.registerSingleton<GetEntitiesUsecase>(GetEntitiesUsecase());
  getIt.registerLazySingleton<AdsService>(
    () => AdsServiceImp(getIt<ApiService>()),
  );
  getIt.registerLazySingleton<AdsRepository>(
    () => AdsRepositoryImp(getIt<AdsService>()),
  );
  getIt.registerLazySingleton(() => AdsUsecase());
  getIt.registerSingleton<GetMedicalDoctorsUseCase>(GetMedicalDoctorsUseCase());
  getIt.registerSingleton<GetMedicalCentersUseCase>(GetMedicalCentersUseCase());
  getIt.registerSingleton<GetSuppliesUsecase>(GetSuppliesUsecase());

  getIt.registerLazySingleton<AppService>(
    () => AppServiceImp(getIt<ApiService>()),
  );
  getIt.registerLazySingleton<AppRepository>(() => AppRepositoryImp());
  getIt.registerLazySingleton(() => ProceduresUsecase());
  getIt.registerSingleton<MedicalSearchUseCase>(MedicalSearchUseCase());

  // Service
  getIt.registerLazySingleton<SuggestionsService>(
    () => SuggestionsServiceImp(getIt<ApiService>()),
  );

  // Repository
  getIt.registerLazySingleton<SuggestionsRepository>(
    () => SuggestionsRepositoryImp(),
  );

  // Usecase
  getIt.registerLazySingleton<SuggestionsUsecase>(() => SuggestionsUsecase());
  getIt.registerLazySingleton<GetProfileUsecase>(() => GetProfileUsecase());
  getIt.registerLazySingleton<GetAboutUsUsecase>(() => GetAboutUsUsecase());
  getIt.registerLazySingleton<SetAppointmentUseCase>(
    () => SetAppointmentUseCase(),
  );
}
