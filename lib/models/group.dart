import 'package:flutter/material.dart';

import 'logic.dart';

class Group {
  final String _name;
  final String _avatarLink;

  Group(this._name, this._avatarLink);

  String getName() {
    if (_name.length > 10) {
      return _name.substring(0, 10) + "...";
    }
    return _name;
  }

  String getGroupName() {
    return _name;
  }

  String getAvatar(){
    return _avatarLink;
  }
}
