import 'package:flutter/material.dart';
import 'package:stoady/models/test.dart';

class Task{
  late int _id;
  late int _testID;
  late String _question;
  late String _answer;

  Task(this._id, this._testID, this._question, this._answer);

  String getQuestion() {
    return _question;
  }

  String getAnswer() {
    return _answer;
  }
}