import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stoady/components/widgets/no_internet.dart';
import 'package:stoady/components/widgets/side_menu.dart';
import 'package:stoady/models/logic.dart';
import 'package:http/http.dart' as http;
import 'package:stoady/models/subject.dart';
import 'package:stoady/models/topic_info.dart';

import 'components/background.dart';

class QuestionManagerPage extends StatefulWidget {
  final bool isNew;

  const QuestionManagerPage({Key? key, required this.isNew}) : super(key: key);

  @override
  State<QuestionManagerPage> createState() => _QuestionManagerPage(isNew);
}

class _QuestionManagerPage extends State<QuestionManagerPage> {
  late final bool isNew;
  late Future<List<TopicInfo>> _currentTopics;

  _QuestionManagerPage(this.isNew);

  @override
  void initState() {
    super.initState();
    if (!isNew) {
      _currentTopics = getTopics();
    }
  }

  Future<List<TopicInfo>> getTopics() async {
    var client = http.Client();
    try {
      var response = await client.get(Uri.https(
          'stoady.herokuapp.com', '/subjects/${Logic.currentSubjectId}'));
      if (response.statusCode == 200) {
        return Subject.fromJsonWithTopics(
            jsonDecode(utf8.decode(response.bodyBytes)))
            .topics;
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
          body: Center(child: Background(isNew: isNew)));
    }
    return Scaffold(
        appBar: AppBar(),
        drawer: const SideMenu(),
        body: FutureBuilder<List<TopicInfo>>(
            future: _currentTopics,
            builder: (BuildContext context,
                AsyncSnapshot<List<TopicInfo>> snapshot) {
              if (snapshot.hasData) {
                Logic.currentSubject.topics = snapshot.data!;
                return Center(child: Background(isNew: isNew));
              } else if (snapshot.hasError) {
                return const NoInternetWidget();
              } else {
                // By default, show a loading spinner.
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }
}
