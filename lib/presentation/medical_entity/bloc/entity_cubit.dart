import 'package:bloc/bloc.dart';
import 'package:medapp/data/medical_entity/model/medical_entity.dart';
import 'package:medapp/domain/medical_entity/usecase/entity_usecase.dart';
import 'package:meta/meta.dart';
import '../../../core/utils/setup_service.dart';

part 'entity_state.dart';

class EntityCubit extends Cubit<EntityState> {
  List<MedicalEntityModel> _entities = [];
  Set<int> _selectedEntityIds = {};

  EntityCubit() : super(EntityInitial());

  Future<void> getEntities({
    int? cityId,
    int? categoryId,
    String? name,
    int? page,
  }) async {
    emit(EntityLoading());

    var result = await getIt<GetEntitiesUsecase>().call(
      cityId: cityId,
      categoryId: categoryId,
      name: name,
      page: page,
    );

    result.fold((failure) => emit(EntityFailure(failure.message)), (entities) {
      _entities = entities;
      emit(
        EntityLoaded(
          entities: _entities,
          selectedEntityIds: _selectedEntityIds,
        ),
      );
    });
  }

  // add search function
  Future<void> searchEntities(String query) async {
    emit(EntityLoading());
    final filteredEntities = _entities
        .where(
          (entity) =>
              entity.nameAr.toLowerCase().contains(query.toLowerCase()) ||
              entity.name.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
    emit(
      EntityLoaded(
        entities: filteredEntities,
        selectedEntityIds: _selectedEntityIds,
      ),
    );
  }
}
