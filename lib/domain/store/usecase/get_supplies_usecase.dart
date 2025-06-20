import 'package:dartz/dartz.dart';
import 'package:medapp/core/errors/failure.dart';
import 'package:medapp/core/usecase/usecase.dart';
import 'package:medapp/core/utils/setup_service.dart';
import 'package:medapp/data/store/model/supplies_model.dart';
import 'package:medapp/domain/store/repository/store_repo.dart';

class GetSuppliesUsecase
    extends Usecase<Either<Failure, List<SuppliesModel>>, dynamic> {
  Future<Either<Failure, List<SuppliesModel>>> call({dynamic params}) async {
    return await getIt<StoreRepository>().getMedicalSupplies();
  }
}
