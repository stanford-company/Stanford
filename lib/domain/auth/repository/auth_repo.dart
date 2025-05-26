import 'package:dartz/dartz.dart';
import 'package:medapp/core/errors/failure.dart';
import 'package:medapp/data/auth/model/check_id.dart';
import 'package:medapp/model/user_model_params.dart';

import '../../../data/auth/model/login.dart';

abstract class AuthRepository {
  Future<Either<Failure,CheckIdModel>>checkId({required String nationalId});
  Future<Either<Failure, UserParams>> login({required UserParams user});




}