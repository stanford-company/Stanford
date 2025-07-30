import 'package:bloc/bloc.dart';
 import 'package:medapp/data/category/model/category.dart';  // Updated to use CategoryModel
import 'package:meta/meta.dart';

import '../../../core/utils/setup_service.dart';
import '../../../domain/category/usecase/category_usecase.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  String categoryId = "";

  List<CategoryModel> _categories=[];
  CategoryCubit() : super(CategoryInitial());

  Future<void> getCategories() async {
    emit(CategoryLoading());
    var result = await getIt<GetCategoriesUsecase>().call();
    result.fold(
          (failure) {
        print(failure.message);
        emit(CategoryFailure(failure.message));
      },
          (categories) async {
            _categories=categories;
        emit(CategoryLoaded(categories, ""));
      },
    );
  }

  void toggleCategorySelection(String categoryId) {

    emit(CategoryLoaded(_categories,categoryId));
  }
}
