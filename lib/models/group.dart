import 'package:flutter/material.dart';
import 'package:stoady/models/subject.dart';
import 'package:stoady/models/user.dart';

import 'logic.dart';

class Group {
  late String name;
  late String picture;
  List<Subject> subjects = [];

  Group(this.name, this.picture, this.subjects);

  factory Group.fromJson(dynamic json) {
    return Group(json['name'] as String, json['picture'] as String,
        (json['subjects'] as List).map((e) => Subject.fromJson(e)).toList());
  }

  Map userInfo = {};

  // Group(String name, String avatarLink, User creator) {
  //   _name = name;
  //   _avatarLink = avatarLink;
  //   userInfo[creator] = true;
  //   //todo delete later;
  //   userInfo[User(1, "Buka", "mr.buka@yandex.ru", "12345", 3)] = false;
  //   userInfo[User(2, "Doctor", "doctor_who@gmail.ru", "12345", 2)] = false;
  //   userInfo[User(3, "Bart", "heycaramba@gmail.ru", "12345", 3)] = true;
  //   userInfo[User(4, "Lou", "tomlinson@mail.ru", "12345", 2)] = false;
  //   userInfo[User(5, "Lou", "tomlinson@mail.ru", "12345", 2)] = false;
  //   userInfo[User(6, "Lou", "tomlinson@mail.ru", "12345", 2)] = false;
  // }

  void adduser(User newUser) {
    userInfo[newUser] = false;
  }

  void deleteUser(User user) {
    userInfo.remove(user);
  }

  bool anyAdmin() {
    int counter = 0;
    for (var elem in userInfo.values) {
      if (elem) {
        counter++;
      }
    }
    return counter > 1;
  }

  void changeAbilities(User curUser) {
    userInfo.update(curUser, (value) => !value);
  }

  bool getAbility(User user) {
    return userInfo[user];
  }

  String getName() {
    if (name.length > 11) {
      return name.substring(0, 11) + "...";
    }
    return name;
  }

  String getGroupName() {
    return name;
  }

  String getAvatar() {
    return picture;
  }
}
