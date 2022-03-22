import 'package:stoady/models/question.dart';

class TopicTest {
  List<Question> questions = [];

  TopicTest(this.questions);

  factory TopicTest.fromJson(dynamic json) {
    return TopicTest((json['questions'] as List)
        .map((e) => Question.fromJsonWithInfo(e))
        .toList());
  }
}
