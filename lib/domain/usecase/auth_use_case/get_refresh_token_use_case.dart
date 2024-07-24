import 'package:dartz/dartz.dart';
import 'package:maids_cc_task/data/network/failure.dart';
import 'package:maids_cc_task/domain/models/auth_model/token_model.dart';
import 'package:maids_cc_task/domain/repository/auth_repository.dart';
import 'package:maids_cc_task/domain/usecase/base_usecase.dart';

class GetRefreshTokenUseCase extends BaseUseCase<void, TokenModel> {
  final AuthRepository _authRepository;

  GetRefreshTokenUseCase(this._authRepository);

  @override
  Future<Either<Failure, TokenModel>> execute(void params) async {
    return await _authRepository.refreshUserToken();
  }
}
