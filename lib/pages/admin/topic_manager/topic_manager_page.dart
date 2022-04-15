import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stoady/components/widgets/empty.dart';
import 'package:stoady/components/widgets/no_internet.dart';
import 'package:stoady/components/widgets/side_menu.dart';
import 'package:stoady/models/group.dart';
import 'package:stoady/models/logic.dart';
import 'package:http/http.dart' as http;
import 'package:stoady/models/question.dart';
import 'package:stoady/models/subject.dart';
import 'package:stoady/models/topic_info.dart';
import 'package:stoady/models/topic_test.dart';

import 'components/body.dart';

class TopicManagerPage extends StatefulWidget {
  final bool isNew;

  const TopicManagerPage({Key? key, required this.isNew}) : super(key: key);

  @override
  State<TopicManagerPage> createState() => _TopicManagerPage(isNew);
}

class _TopicManagerPage extends State<TopicManagerPage> {
  late final bool isNew;
  late Future<List<Question>> _currentQuestions;
  late Future<TopicInfo> _currentTopic;

  _TopicManagerPage(this.isNew);

  @override
  void initState() {
    super.initState();
    if (!isNew) {
      _currentQuestions = getQuestions();
      _currentTopic = getTopic();
    }
  }

  Future<TopicInfo> getTopic() async {
    var client = http.Client();
    try {
      var response = await client.get(
          Uri.https('stoady.herokuapp.com', '/topics/${Logic.currentTopicId}'));
      if (response.statusCode == 200) {
        return TopicInfo.fromJsonWithQuestions(
            jsonDecode(utf8.decode(response.bodyBytes)));
      } else {
        // todo handle exception
        throw Exception();
      }
    } finally {
      client.close();
    }
  }

  Future<List<Question>> getQuestions() async {
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

  @override
  Widget build(BuildContext context) {
    if (isNew) {
      return Scaffold(
          appBar: AppBar(),
          drawer: const SideMenu(),
          body: Center(child: Body(isNew: isNew)));
    }
    return Scaffold(
        appBar: AppBar(),
        drawer: const SideMenu(),
        body: FutureBuilder<TopicInfo>(
            future: _currentTopic,
            builder: (BuildContext context,
                AsyncSnapshot<TopicInfo> snapshot) {
              if (snapshot.hasData) {
                Logic.currentTopicInfo = snapshot.data!;
                return FutureBuilder<List<Question>>(
                    future: _currentQuestions,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Question>> snapshot) {
                      if (snapshot.hasData) {
                        Logic.currentTopicInfo.questions = snapshot.data!;
                        return Center(child: Body(isNew: isNew));
                      } else if (snapshot.hasError) {
                        return const NoInternetWidget();
                      } else {
                        // By default, show a loading spinner.
                        return const Center(child: CircularProgressIndicator());
                      }
                    });
              } else if (snapshot.hasError) {
                return const NoInternetWidget();
              } else {
                // By default, show a loading spinner.
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }
}
