class Question {
  late int id;
  late String questionText;
  late String answerText;

  Question(this.id);

  Question.withInfo(this.id, this.questionText, this.answerText);

  factory Question.fromJsonWithInfo(dynamic json) {
    return Question.withInfo(json['id'] as int, json['questionText'] as String,
        json['answerText'] as String);
  }

  factory Question.fromJson(dynamic json) {
    return Question(json['id'] as int);
  }
}
