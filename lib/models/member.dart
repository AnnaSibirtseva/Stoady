import 'package:stoady/models/role.dart';

class Member {
  late int id;
  late String username;
  late String email;
  late Role role;

  Member(this.id, this.username, this.email, String str) {
    role = Role.values.firstWhere((e) => e.toString() == "Role." + str);
  }

  factory Member.fromJson(dynamic json) {
    return Member(json['id'] as int, json['username'] as String,
        json['email'] as String, json['role'] as String);
  }

  bool isAdmin() {
    if (role == Role.Admin || role == Role.Creator) {
      return true;
    }
    return false;
  }
}
