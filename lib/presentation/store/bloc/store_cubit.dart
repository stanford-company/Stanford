import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/utils/setup_service.dart';
import '../../../data/store/model/supplies_model.dart';
import '../../../domain/store/usecase/get_supplies_usecase.dart';

part 'store_state.dart';

class StoreCubit extends Cubit<StoreState> {
  StoreCubit() : super(StoreInitial());

  List<SuppliesModel> _allSupplies = [];

  Future<void> getMedicalSupplies() async {
    emit(StoreSupplyLoading());
    var result = await getIt<GetSuppliesUsecase>().call();
    result.fold(
      (failure) {
        print(failure.message);
        emit(StoreSupplyFailure());
      },
      (supplies) {
        _allSupplies = supplies;
        emit(StoreSupplyLoaded(supplies));
      },
    );
  }

  void searchSupplies(String query) {
    if (query.isEmpty) {
      emit(StoreSupplyLoaded(_allSupplies));
      return;
    }

    final filteredSupplies = _allSupplies.where((supply) {
      final nameArLower = supply.nameAr?.toLowerCase() ?? '';
      final nameEnLower = supply.nameEn?.toLowerCase() ?? '';
      final queryLower = query.toLowerCase();

      return nameArLower.contains(queryLower) ||
          nameEnLower.contains(queryLower);
    }).toList();

    emit(
      StoreSupplyLoaded(
        _allSupplies,
        filteredSupplies: filteredSupplies,
        searchQuery: query,
      ),
    );
  }

  void clearSearch() {
    emit(StoreSupplyLoaded(_allSupplies));
  }
}
