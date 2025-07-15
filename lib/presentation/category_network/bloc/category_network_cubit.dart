import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:medapp/data/category_network/model/category.dart';
import 'package:medapp/core/utils/setup_service.dart';
import 'package:medapp/domain/category_network/usecase/category_network_usecase.dart';

part 'category_network_state.dart';

class CategoryNetworkCubit extends Cubit<CategoryNetworkState> {
  CategoryNetworkCubit() : super(CategoryNetworkInitial());

  Future<void> getNetworkCategories() async {
    emit(CategoryNetworkLoading());

    final result = await getIt<GetCategoriesNetworkUsecase>().call();

    result.fold(
          (failure) => emit(CategoryNetworkFailure(failure.message)),
          (categories) => emit(CategoryNetworkLoaded(categories)),
    );
  }
}
