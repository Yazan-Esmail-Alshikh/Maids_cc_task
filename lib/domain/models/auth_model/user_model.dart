import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  int id;
  String userName;
  String email;
  String firstName;
  String lastName;
  String gender;
  String image;
  String token;
  String refreshToken;

  UserModel({
    required this.userName,
    required this.token,
    required this.refreshToken,
    required this.id,
    required this.lastName,
    required this.firstName,
    required this.email,
    required this.image,
    required this.gender,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserModel &&
        other.id == id &&
        other.userName == userName &&
        other.email == email &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.gender == gender &&
        other.image == image &&
        other.token == token &&
        other.refreshToken == refreshToken;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      userName.hashCode ^
      email.hashCode ^
      firstName.hashCode ^
      lastName.hashCode ^
      gender.hashCode ^
      image.hashCode ^
      token.hashCode ^
      refreshToken.hashCode;
}
