import 'package:dartz/dartz.dart';
import 'package:maids_cc_task/data/network/failure.dart';
import 'package:maids_cc_task/data/params/auth_params/login_params.dart';
import 'package:maids_cc_task/domain/models/auth_model/token_model.dart';
import 'package:maids_cc_task/domain/models/auth_model/user_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, TokenModel>> refreshUserToken();

  Future<Either<Failure, UserModel>> login(LoginParams params);
}
