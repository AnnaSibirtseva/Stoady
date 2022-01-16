import 'package:flutter/material.dart';
import 'package:stoady/models/logic.dart';
import 'package:stoady/models/test.dart';

class Topic {
  late int _id;
  late String _title;
  late String _description;
  late int _subjectID;
  int _testID;
  Test test = Test(0, 0);

  Topic(
      this._id, this._title, this._description, this._subjectID, this._testID);


  String getTitle() {
    return _title;
  }

  String getDescription() {
    return _description;
  }

  int getId() {
    return _id;
  }

  String getSubjectName() {
    return Logic.allSubjects.where((subject) => subject.getID() == _subjectID).toList()[0].getTitle();
  }

  Test getTestId() {
    //TODO тут запрос в бд, где айди теста будет пожходить. (не забыть поменять еще тип вз)
    return Test(0, 0);
  }
}
