import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/utils/setup_service.dart';
import '../../../data/medical_entity/model/medical_entity.dart';
import '../../../domain/medical_entity/usecase/medical_search.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  Future<void> medicalSearch({required String name}) async {
    emit(SearchLoading());
    var result = await getIt<MedicalSearchUseCase>().call(params: name);
    result.fold(
      (failure) {
        print(failure.message);
        emit(SearchFailure());
      },
      (entities) {
        emit(SearchLoaded(entities));
      },
    );
  }
}
