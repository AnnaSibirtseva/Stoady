import 'package:stoady/models/question.dart';

class TopicInfo {
  late int id;
  late String name;
  late String description;
  late List<Question> questions = [];

  TopicInfo(this.id, this.name);

  TopicInfo.withQuestions(this.name, this.description, this.questions);

  factory TopicInfo.fromJson(dynamic json) {
    return TopicInfo(json['id'] as int, json['name'] as String);
  }

  factory TopicInfo.fromJsonWithQuestions(dynamic json) {
    return TopicInfo.withQuestions(
        json['name'] as String, json['description'] as String,
        (json['questions'] as List).map((e) => Question.fromJson(e)).toList());
  }
}
