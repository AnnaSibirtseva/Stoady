import 'package:flutter/material.dart';
import 'package:stoady/models/task.dart';

class Test {
  late int _id;
  late int _topicID;
  late List<Task> questions = [
    Task(
        0,
        0,
        "What are numbers, symbols, or expressions in the matrix called?",
        "entries or elements"),
    Task(0, 0, "q2", "a2")
  ];

  Test(this._id, this._topicID);

  int getId() {
    return _id;
  }

  String getQuestion(int index) {
    return questions[index].getQuestion();
  }

  String getAnswer(int index) {
    return questions[index].getAnswer();
  }
}
