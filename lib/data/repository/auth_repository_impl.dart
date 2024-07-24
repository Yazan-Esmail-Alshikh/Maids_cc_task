import 'package:dartz/dartz.dart';
import 'package:maids_cc_task/app/app_pref.dart';
import 'package:maids_cc_task/data/data_source/auth_data_source/auth_remote_data_source.dart';
import 'package:maids_cc_task/data/mapper/auth_mapper.dart';
import 'package:maids_cc_task/data/network/error_handler.dart';
import 'package:maids_cc_task/data/network/failure.dart';
import 'package:maids_cc_task/data/network/network_info.dart';
import 'package:maids_cc_task/data/params/auth_params/login_params.dart';
import 'package:maids_cc_task/data/params/auth_params/token_params.dart';
import 'package:maids_cc_task/domain/models/auth_model/token_model.dart';
import 'package:maids_cc_task/domain/models/auth_model/user_model.dart';
import 'package:maids_cc_task/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final NetworkInfo _networkInfo;
  final AppPreferences _appPreferences;
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRepositoryImpl(
    this._authRemoteDataSource,
    this._appPreferences,
    this._networkInfo,
  );

  @override
  Future<Either<Failure, TokenModel>> refreshUserToken() async {
    if (await _networkInfo.isConnected) {
      try {
        final params = TokenParams(
          refreshToken: _appPreferences.getUserRefreshToken(),
          expiresInMins: 30,
        );
        final response = await _authRemoteDataSource.getRefreshToken(params);
        return Right(response.toDomain());
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, UserModel>> login(LoginParams params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _authRemoteDataSource.login(params);
        return Right(response.toDomain());
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }
}
