import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/const.dart';
import '../../../core/errors/failure.dart';
import '../../../core/services/api_service.dart';
import '../../../core/utils/setup_service.dart';
import '../../../core/utils/shared_prefs_service.dart';
import '../../../domain/suggestions/repository/suggestions_repo.dart';
import '../model/suggestions.dart';
import '../service/suggestions.dart';
import '../../../common/helper/cach_helper/cach_helper.dart';

class SuggestionsRepositoryImp extends SuggestionsRepository {
  final ApiService apiService = getIt<ApiService>();

  @override
  Future<Either<Failure, SuggestionResponse>> suggestions({
    required String title,
    required String description,
  }) async {
    try {
      final token = await SharedPrefsService.getToken();

      if (token != null && token.isNotEmpty) {
        await CacheHelper.saveData(key: TextConst.userToken, value: token);
        print('✅ Token saved to CacheHelper');
      } else {
        print('❌ Token is null or empty. Aborting suggestion send.');
        return Left(ServerFailure("Authentication token is missing. Please log in again."));
      }


      final suggestionResponse = await getIt<SuggestionsService>().sendSuggestion(
        title,
        description,
      );

      return Right(suggestionResponse);
    } catch (e, stacktrace) {
      print('❌ ERROR during sendSuggestion: $e');
      print('📍 StackTrace: $stacktrace');
      return Left(_handleError(e));
    }
  }

  Failure _handleError(dynamic e) {
    if (e is DioException) {
      return ServerFailure.fromDioError(e);
    }
    return ServerFailure(e.toString());
  }
}
