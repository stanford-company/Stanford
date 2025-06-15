import 'package:dartz/dartz.dart';
import 'package:medapp/data/suggestions/model/suggestions.dart';
import '../../../core/errors/failure.dart';
import '../../../core/usecase/usecase.dart';
import '../../../core/utils/setup_service.dart';
import '../../../data/auth/model/login.dart';
import '../repository/suggestions_repo.dart';

class SuggestionsUsecase extends Usecase<Either<Failure, SuggestionResponse>, Map<String, String>> {
  @override
  Future<Either<Failure, SuggestionResponse>> call({required Map<String, String> params}) async {
    return await getIt<SuggestionsRepository>().suggestions(
      title: params['title']!,
      description: params["description"]!,
    );
  }
}
