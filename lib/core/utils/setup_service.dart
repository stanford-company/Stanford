import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:medapp/data/category/repository/category_repo_imp.dart';
import 'package:medapp/data/category/service/category.dart';
import 'package:medapp/domain/category/repository/category_repo.dart';

import '../../data/auth/repository/auth_repo_imp.dart';
import '../../data/auth/service/auth_service.dart';
import '../../domain/auth/repository/auth_repo.dart';
import '../../domain/auth/usecase/check_id_usecase.dart';
import '../../domain/category/usecase/category_usecase.dart';
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



  //repository
  getIt.registerSingleton<AuthRepository>(AuthRepositoryImp());
  getIt.registerSingleton<CategoryRepository>(CategoryRepositoryImp());


  //usecase
  getIt.registerSingleton<CheckIdUsecase>(CheckIdUsecase());
  getIt.registerSingleton<GetCategoriesUsecase>(GetCategoriesUsecase());



}