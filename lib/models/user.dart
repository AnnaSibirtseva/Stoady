import 'package:stoady/models/auth_info.dart';
import 'package:stoady/models/question.dart';
import 'package:stoady/models/random.dart';

class User {
  late int id;
  late String name;
  late String email;
  late String password;
  late int avatarId;
  List<Question> saved = [];

  User(this.id, this.name, this.email, this.password, this.avatarId);

  User.auth(this.id, this.name, this.avatarId);

  factory User.fromJson(dynamic json) {
    return User.auth(
        json['id'] as int, json['name'] as String, json['avatarId'] as int);
  }

  factory User.registerFromJson(dynamic json, AuthInfo userInfo) {
    return User(json['userId'] as int, userInfo.userName, userInfo.email,
        userInfo.password, userInfo.avatarId);
  }

  void setMailPassword(AuthInfo info) {
    email = info.email;
    password = info.password;
  }

  int getId() {
    return id;
  }

  String getName() {
    return name;
  }

  String getEmail() {
    return email;
  }

  void setMail(String mail) {
    email = mail;
  }

  String getAvatar() {
    return Avatar.getAvatar(avatarId);
  }

  bool isSaved(Question question) {
    if (saved.any((element) => element.id == question.id)) {
      return true;
    }
    return false;
  }
}
