part of 'entity_cubit.dart';

@immutable
abstract class EntityState {}

class EntityInitial extends EntityState {}

class EntityLoading extends EntityState {}

class EntityFailure extends EntityState {
  final String message;
  EntityFailure(this.message);
}

class EntityLoaded extends EntityState {
  final List<MedicalEntityModel> entities;
  final Set<int> selectedEntityIds;

  EntityLoaded({required this.entities, required this.selectedEntityIds});
}
