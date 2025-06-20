import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/utils/setup_service.dart';
import '../../../data/store/model/supplies_model.dart';
import '../../../domain/store/usecase/get_supplies_usecase.dart';

part 'store_state.dart';

class StoreCubit extends Cubit<StoreState> {
  StoreCubit() : super(StoreInitial());

  Future<void> getMedicalSupplies() async {
    emit(StoreSupplyLoading());
    var result = await getIt<GetSuppliesUsecase>().call();
    result.fold(
      (failure) {
        print(failure.message);
        emit(StoreSupplyFailure());
      },
      (supplies) {
        emit(StoreSupplyLoaded(supplies));
      },
    );
  }
}
