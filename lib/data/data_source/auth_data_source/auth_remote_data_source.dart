import 'package:maids_cc_task/data/network/app_api.dart';
import 'package:maids_cc_task/data/network/end_point.dart';
import 'package:maids_cc_task/data/params/auth_params/login_params.dart';
import 'package:maids_cc_task/data/params/auth_params/token_params.dart';
import 'package:maids_cc_task/data/response/auth_response/token_response.dart';
import 'package:maids_cc_task/data/response/auth_response/user_response.dart';

abstract class AuthRemoteDataSource {
  Future<TokenResponse> getRefreshToken(TokenParams params);

  Future<UserResponse> login(LoginParams params);
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final AppServiceClient _appServiceClient;

  AuthRemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<TokenResponse> getRefreshToken(TokenParams params) async {
    return await _appServiceClient.performPostRequest(
      EndPoint.refreshAuthToken,
      params.toJson(),
      TokenResponse.fromJson,
    );
  }

  @override
  Future<UserResponse> login(LoginParams params) async {
    return await _appServiceClient.performPostRequest(
      EndPoint.login,
      params.toJson(),
      UserResponse.fromJson,
    );
  }
}
