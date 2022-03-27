import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stoady/components/widgets/no_internet.dart';
import 'package:stoady/components/widgets/side_menu.dart';
import 'package:stoady/models/logic.dart';
import 'package:stoady/models/question.dart';
import 'package:stoady/models/topic_test.dart';
import 'package:stoady/pages/user/learn/components/background.dart';
import 'package:http/http.dart' as http;

class LearningPage extends StatefulWidget {
  static bool isSaved = false;

  const LearningPage({Key? key}) : super(key: key);

  @override
  State<LearningPage> createState() => _LearningPage();
}

class _LearningPage extends State<LearningPage> {
  late Future<List<Question>> _futureQuestions;
  late Future<List<Question>> _futureSavedQuestions;
  late bool isSaved;

  @override
  void initState() {
    super.initState();
    // Since field is static we should reset it.
    Logic.currentIndex = 0;
    isSaved = LearningPage.isSaved;
    _futureSavedQuestions = getSavedQuestions();
    _futureQuestions = isSaved ? _futureSavedQuestions : getQuestions();
  }

  Future<List<Question>> getQuestions() async {
    Logic.currentUser.saved = await _futureSavedQuestions;
    var client = http.Client();
    try {
      var response = await client.get(Uri.https(
          'stoady.herokuapp.com', '/questions/${Logic.currentTopicId}'));
      if (response.statusCode == 200) {
        return TopicTest.fromJson(jsonDecode(utf8.decode(response.bodyBytes)))
            .questions;
      } else {
        // todo handle exception
        throw Exception();
      }
    } finally {
      client.close();
    }
  }

  Future<List<Question>> getSavedQuestions() async {
    var client = http.Client();
    try {
      var response = await client.get(Uri.https(
          'stoady.herokuapp.com', '/questions/saved/${Logic.currentUser.id}'));
      if (response.statusCode == 200) {
        return TopicTest.savedFromJson(
                jsonDecode(utf8.decode(response.bodyBytes)))
            .questions;
      } else {
        // todo handle exception
        throw Exception();
      }
    } finally {
      client.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        drawer: const SideMenu(),
        body: FutureBuilder<List<Question>>(
            future: _futureQuestions,
            builder:
                (BuildContext context, AsyncSnapshot<List<Question>> snapshot) {
              if (snapshot.hasData) {
                Logic.questions = snapshot.data!;
                if (isSaved) {
                  Logic.currentUser.saved = snapshot.data!;
                }
                if (Logic.questions.isNotEmpty) {
                  return Center(child: Background(child: Container()));
                }
                return AlertDialog(
                  title: const Text("Information"),
                  content:
                      const Text("There are no questions in this topic yet."),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                    )
                  ],
                );
              } else if (snapshot.hasError) {
                return const NoInternetWidget();
              } else {
                // By default, show a loading spinner.
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }
}
