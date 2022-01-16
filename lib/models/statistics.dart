import 'package:flutter/material.dart';

import 'logic.dart';

class Statistics {
  late int _userID;
  late int _topicID;
  late int _lastScore;

  Statistics(this._userID, this._topicID, this._lastScore);

  String getTopic() {
    return Logic.getTopicName(_topicID);
  }

  int getLastScore() {
    return _lastScore;
  }
}
