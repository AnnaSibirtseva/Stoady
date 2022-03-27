import 'package:stoady/models/question.dart';

class TopicTest {
  List<Question> questions = [];

  TopicTest(this.questions);

  factory TopicTest.fromJson(dynamic json) {
    return TopicTest((json['questions'] as List)
        .map((e) => Question.fromJsonWithInfo(e))
        .toList());
  }

  factory TopicTest.savedFromJson(dynamic json) {
    return TopicTest((json['savedQuestions'] as List)
        .map((e) => Question.fromJsonWithInfo(e))
        .toList());
  }
}
