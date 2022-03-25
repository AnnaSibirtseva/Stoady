import 'package:stoady/models/role.dart';

class UserGroup {
  late int teamId;
  late Role role;
  late String teamName;
  late String teamAvatar;

  UserGroup(this.teamId, String str, this.teamName, this.teamAvatar) {
    role = Role.values.firstWhere((e) => e.toString() == "Role." + str);
  }

  factory UserGroup.fromJson(dynamic json) {
    return UserGroup(json['teamId'] as int, json['role'] as String,
        json['teamName'] as String, json['teamAvatar'] as String);
  }

  bool isAdmin() {
    if (role == Role.Admin || role == Role.Creator) {
      return true;
    }
    return false;
  }
}
