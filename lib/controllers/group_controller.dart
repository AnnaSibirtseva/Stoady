import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:stoady/models/group.dart';
import 'package:stoady/models/logic.dart';

class PostController extends ControllerMVC {

  // конструктор нашего контроллера
  PostController();

  void init() async {
    try {
      var client = http.Client();
      try {
        var response = await client
            .get(Uri.https('stoady.herokuapp.com', '/teams/${Logic.currentUser.getId()}'));
        Logic.currentGroup =
            Group.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
        Logic.allSubjects = Logic.currentGroup.subjects;
        setState(() {});
      } finally {
        client.close();
      }
    } catch (error) {
      setState(() => const SnackBar(content: Text("Something went wrong. Check your internet connection")));
    }
  }


}