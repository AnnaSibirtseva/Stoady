import 'package:stoady/models/subject.dart';

class Group {
  late String name;
  late String picture;
  List<Subject> subjects = [];

  Group(this.name, this.picture, this.subjects);

  factory Group.fromJson(dynamic json) {
    return Group(json['name'] as String, json['picture'] as String,
        (json['subjects'] as List).map((e) => Subject.fromJson(e)).toList());
  }

  String getName() {
    if (name.length > 11) {
      return name.substring(0, 11) + "...";
    }
    return name;
  }

  String getGroupName() {
    return name;
  }

  String getAvatar() {
    return picture;
  }
}
