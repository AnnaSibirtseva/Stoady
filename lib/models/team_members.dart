import 'package:stoady/models/member.dart';
import 'package:stoady/models/role.dart';

class TeamMembers {
  List<Member> members = [];

  TeamMembers(this.members);

  factory TeamMembers.fromJson(dynamic json) {
    return TeamMembers(
        (json['members'] as List).map((e) => Member.fromJson(e)).toList());
  }

  bool anyAdmin() {
    return members.any((element) => element.isAdmin());
  }

  void changeAbility(Member member) {
    if (member.isAdmin()) {
      member.role = Role.Member;
    } else {
      member.role = Role.Admin;
    }
  }
}
