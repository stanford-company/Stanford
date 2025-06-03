import 'package:dartz/dartz.dart';
import 'package:medapp/core/errors/failure.dart';
import 'package:medapp/data/auth/model/check_id.dart';
import 'package:medapp/data/auth/model/logout.dart';
import 'package:medapp/data/auth/model/register.dart';

import '../../../data/auth/model/login.dart';

abstract class AuthRepository {
  Future<Either<Failure, CheckIdModel>> checkId({required String nationalId});
  Future<Either<Failure, UserParams>> register({ // ✅ FIXED: return UserParams
    required String nationalId,
    required String email,
    required String password,
  });
  Future<Either<Failure, UserParams>> login({
    required String nationalId,
    required String password,
  });
  Future<Either<Failure, String>> forgotPassword({ // ✅ FIXED: return UserParams
    required String nationalId,
    required String confirmPassword,
    required String password,
  });
  Future<Either<Failure, LogoutModel>> logout({required String token});
}

