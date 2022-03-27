class AuthInfo{
  late String email;
  late String password;

  AuthInfo(this.email, this.password);

  factory AuthInfo.fromJson(dynamic json) {
    return AuthInfo(json['email'] as String, json['password'] as String);
  }
}