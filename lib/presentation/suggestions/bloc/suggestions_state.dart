import 'package:medapp/data/suggestions/model/suggestions.dart';

sealed class SuggestionsState {}

final class SuggestionsInitial extends SuggestionsState {}

final class SuggestionsLoading extends SuggestionsState {}

final class SuggestionsSuccess extends SuggestionsState {
  final SuggestionResponse suggestion;

  SuggestionsSuccess(this.suggestion);
}

final class SuggestionsFailure extends SuggestionsState {
  final String message;

  SuggestionsFailure(this.message);
}
