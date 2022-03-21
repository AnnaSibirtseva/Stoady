import 'package:stoady/models/user_group.dart';

class GroupMembers {
  List<UserGroup> members = [];

  GroupMembers(this.members);

  factory GroupMembers.fromJson(dynamic json) {
    return GroupMembers(
        (json['teams'] as List).map((e) => UserGroup.fromJson(e)).toList());
  }
}
