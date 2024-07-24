import 'package:dartz/dartz.dart';
import 'package:maids_cc_task/data/network/failure.dart';
import 'package:maids_cc_task/data/params/auth_params/login_params.dart';
import 'package:maids_cc_task/domain/models/auth_model/user_model.dart';
import 'package:maids_cc_task/domain/repository/auth_repository.dart';
import 'package:maids_cc_task/domain/usecase/base_usecase.dart';

class LoginUseCase extends BaseUseCase<LoginParams, UserModel> {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  @override
  Future<Either<Failure, UserModel>> execute(LoginParams params) async {
    return await _authRepository.login(params);
  }
}
