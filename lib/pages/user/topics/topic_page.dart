import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stoady/components/widgets/no_internet.dart';
import 'package:stoady/components/widgets/side_menu.dart';
import 'package:http/http.dart' as http;
import 'package:stoady/models/logic.dart';
import 'package:stoady/models/topic_info.dart';

import 'components/body.dart';

class TopicPage extends StatefulWidget {
  const TopicPage({Key? key}) : super(key: key);

  @override
  State<TopicPage> createState() => _TopicPage();
}

class _TopicPage extends State<TopicPage> {
  late Future<TopicInfo> _currentTopic;

  @override
  void initState() {
    super.initState();
    _currentTopic = getTopic();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        drawer: const SideMenu(),
        body: FutureBuilder<TopicInfo>(
            future: _currentTopic,
            builder: (BuildContext context, AsyncSnapshot<TopicInfo> snapshot) {
              if (snapshot.hasData) {
                Logic.currentTopicInfo = snapshot.data!;
                return Center(
                    child: Body(currentTopic: Logic.currentTopicInfo));
              } else if (snapshot.hasError) {
                return const NoInternetWidget();
              } else {
                // By default, show a loading spinner.
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }
}
