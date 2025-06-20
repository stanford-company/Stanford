import 'package:bloc/bloc.dart';
import 'package:medapp/presentation/procedures/bloc/procedures_state.dart';
import 'package:medapp/core/errors/failure.dart';
import 'package:medapp/core/utils/setup_service.dart';
 import 'package:medapp/domain/procedures/usecase/procedures_usecase.dart';

import '../../../data/procedures/model/procedures.dart';

class ProcedureCubit extends Cubit<ProcedureState> {
  ProcedureCubit() : super(ProcedureInitial());

  Future<void> fetchProcedure() async {
    emit(ProcedureLoading());

    final result = await getIt<ProceduresUsecase>().call();

    result.fold(
          (Failure failure) => emit(ProcedureError(message: failure.message)),
          (List<ProcedureModel> procedures) => emit(ProcedureLoaded(procedures: procedures)),
    );
  }
}
