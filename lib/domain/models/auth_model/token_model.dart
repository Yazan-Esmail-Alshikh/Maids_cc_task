class TokenModel {
  String token;
  String refreshToken;

  TokenModel({required this.token, required this.refreshToken});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TokenModel &&
        other.token == token &&
        other.refreshToken == refreshToken;
  }

  @override
  int get hashCode => token.hashCode ^ refreshToken.hashCode;
}
