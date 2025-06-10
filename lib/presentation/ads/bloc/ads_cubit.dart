import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:medapp/domain/ads/usecase/ads_usecase.dart';
import 'package:medapp/data/ads/model/ads.dart';
import 'package:medapp/core/errors/failure.dart';
import 'package:medapp/core/utils/setup_service.dart';

part 'ads_state.dart';

class AdsCubit extends Cubit<AdsState> {
  AdsCubit() : super(AdsInitial());

  /// Fetch ads using token passed manually (optional use)
  Future<void> fetchAds(String token) async {
    emit(AdsLoading());

    final result = await getIt<AdsUsecase>().call(params: token);

    result.fold(
          (Failure failure) => emit(AdsError(message: failure.message)),
          (AdsModel ads) => emit(AdsLoaded(ads: ads)),
    );
  }

  /// ✅ Automatically fetch ads using token from SharedPreferences
  Future<void> fetchAdsFromSharedPreferences() async {
    emit(AdsLoading());

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token != null) {
      final result = await getIt<AdsUsecase>().call(params: token);

      result.fold(
            (Failure failure) => emit(AdsError(message: failure.message)),
            (AdsModel ads) => emit(AdsLoaded(ads: ads)),
      );
    } else {
      emit(AdsError(message: 'Token not found in storage'));
    }
  }
}
