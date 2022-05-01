import 'package:stoady/models/topic_info.dart';

class Subject {
  late int id;
  late final String name;
  late final String description;
  late List<TopicInfo> topics = [];

  Subject(this.id,
          this.name,
          this.description);

  Subject.withTopics(this.name, this.description, this.topics);

  factory Subject.fromJson(dynamic json) {
    return Subject(json['id'] as int, json['name'] as String,
        json['description'] as String);
  }

  factory Subject.fromJsonWithTopics(dynamic json) {
    return Subject.withTopics(json['name'] as String, json['description'] as String,
        (json['topics'] as List).map((e) => TopicInfo.fromJson(e)).toList());
  }

  String getTitle() {
    return name;
  }

  int getID() {
    return id;
  }

  String getDescription() {
    return description;
  }
}
