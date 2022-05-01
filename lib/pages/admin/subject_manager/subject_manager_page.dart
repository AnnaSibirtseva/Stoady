import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stoady/components/widgets/no_internet.dart';
import 'package:stoady/components/widgets/side_menu.dart';
import 'package:stoady/models/logic.dart';
import 'package:http/http.dart' as http;
import 'package:stoady/models/subject.dart';
import 'package:stoady/models/topic_info.dart';

import 'components/body.dart';

class SubjectManagerPage extends StatefulWidget {
  final bool isNew;

  const SubjectManagerPage({Key? key, required this.isNew}) : super(key: key);

  @override
  State<SubjectManagerPage> createState() => _SubjectManagerPage(isNew);
}

class _SubjectManagerPage extends State<SubjectManagerPage> {
  late final bool isNew;
  late Future<List<TopicInfo>> _currentTopics;

  _SubjectManagerPage(this.isNew);

  @override
  void initState() {
    super.initState();
    if (!isNew) {
      _currentTopics = getSubject();
    }
  }

  Future<List<TopicInfo>> getSubject() async {
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
          body: Center(child: Body(isNew: isNew)));
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
                return Center(child: Body(isNew: isNew));
              } else if (snapshot.hasError) {
                return const NoInternetWidget();
              } else {
                // By default, show a loading spinner.
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }
}
