import '../../../core/services/api_service.dart';
import '../model/suggestions.dart';

abstract class SuggestionsService {
  Future<SuggestionResponse> sendSuggestion(String title, String description);
}



class SuggestionsServiceImp extends SuggestionsService {
  final ApiService apiService;

  SuggestionsServiceImp(this.apiService);

  @override
  Future<SuggestionResponse> sendSuggestion(String title, String description) async {
    final data = await apiService.post(
      endPoint: "suggestions/store",
      body: {
        "title": title,
        "description": description,
      },
    );
    return SuggestionResponse.fromJson(data);
  }

}


