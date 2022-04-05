class AuthInfo {
  late String email;
  late String password;
  late int avatarId;
  late String userName;

  AuthInfo(this.email, this.password);

  AuthInfo.registerInfo(
      this.userName, this.password, this.email, this.avatarId);

  factory AuthInfo.fromJson(dynamic json) {
    return AuthInfo(json['email'] as String, json['password'] as String);
  }
}
