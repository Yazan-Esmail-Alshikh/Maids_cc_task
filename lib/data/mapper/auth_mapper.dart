import 'package:maids_cc_task/app/constants.dart';
import 'package:maids_cc_task/data/response/auth_response/token_response.dart';
import 'package:maids_cc_task/data/response/auth_response/user_response.dart';
import 'package:maids_cc_task/domain/models/auth_model/token_model.dart';
import 'package:maids_cc_task/domain/models/auth_model/user_model.dart';

extension TokenMapper on TokenResponse? {
  TokenModel toDomain() {
    return TokenModel(
      token: this?.token ?? Constants.empty,
      refreshToken: this?.refreshToken ?? Constants.empty,
    );
  }
}

extension UserMapper on UserResponse? {
  UserModel toDomain() {
    return UserModel(
      userName: this?.userName ?? Constants.empty,
      token: this?.token ?? Constants.empty,
      refreshToken: this?.refreshToken ?? Constants.empty,
      id: this?.id ?? Constants.zero,
      lastName: this?.lastName ?? Constants.empty,
      firstName: this?.firstName ?? Constants.empty,
      email: this?.email ?? Constants.empty,
      image: this?.image ?? Constants.empty,
      gender: this?.gender ?? Constants.empty,
    );
  }
}
