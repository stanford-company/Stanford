import '../../../core/services/api_service.dart';
import '../model/ads.dart';

abstract class AdsService {
  Future<AdsModel> ads({required String token});
}

class AdsServiceImp extends AdsService {
  final ApiService apiService;

  AdsServiceImp(this.apiService);

  @override
  Future<AdsModel> ads({required String token}) async {
    try {
      var data = await apiService.get(
        endPoint: "adds",
        // Optional: remove if not needed

      );
      print('📦 Ads JSON Response: $data');

      return AdsModel.fromJson(data);
    } catch (e, s) {
      print("❌ Exception in ads(): $e");
      print("🪵 StackTrace: $s");
      rethrow;
    }
  }
}
