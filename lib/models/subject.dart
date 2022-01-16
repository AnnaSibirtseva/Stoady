import 'package:flutter/material.dart';

class Subject {
  late int _id;
  late final String _title;
  late final String _description;

  Subject(this._id,
          this._title,
          this._description);

  String getTitle() {
    return _title;
  }

  int getID() {
    return _id;
  }

  String getDescription() {
    return _description;
  }
}
