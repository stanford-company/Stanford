import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medapp/presentation/suggestions/bloc/suggestions_state.dart';
import 'package:medapp/core/utils/setup_service.dart';
import 'package:medapp/domain/suggestions/usecase/suggestions_usecase.dart';
import 'package:medapp/data/suggestions/model/suggestions.dart';

class SuggestionsCubit extends Cubit<SuggestionsState> {
  SuggestionsCubit() : super(SuggestionsInitial());

  Future<void> sendSuggestion({
    required String title,
    required String description,
  }) async {
    emit(SuggestionsLoading());

    final result = await getIt<SuggestionsUsecase>().call(
      params: {
        'title': title,
        'description': description,
      },
    );

    result.fold(
          (failure) => emit(SuggestionsFailure(failure.message)),
          (suggestion) => emit(SuggestionsSuccess(suggestion)),
    );
  }
}
