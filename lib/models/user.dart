import 'package:flutter/material.dart';
import 'package:stoady/models/statistics.dart';
import 'package:stoady/models/task.dart';

import 'logic.dart';

class User {
  late int _id;
  late String _name;
  late String _email;
  late String _password;
  late int _photoIndex;
  List<Statistics> statistics = [Statistics(0, 0, 28), Statistics(0, 1, 16)];
  List<Task> saved = [];

  User(this._id, this._name, this._email, this._password, this._photoIndex);

  void addTask(Task task) {
    saved.add(task);
  }

  void removeTask(Task task) {
    saved.remove(task);
  }

  String getName() {
    return _name;
  }

  String getEmail() {
    return _email;
  }

  bool isSaved(Task task) {
    if (saved.contains(task)) {
      return true;
    }
    return false;
  }
}
