import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stoady/components/widgets/no_internet.dart';
import 'package:stoady/components/widgets/side_menu.dart';
import 'package:stoady/models/logic.dart';
import 'package:stoady/models/subject.dart';

import 'components/body.dart';
import 'package:http/http.dart' as http;

class SubjectPage extends StatefulWidget {
  const SubjectPage({Key? key}) : super(key: key);

  @override
  State<SubjectPage> createState() => _SubjectPage();
}

class _SubjectPage extends State<SubjectPage> {
  late Future<Subject> _currentSubject;

  @override
  void initState() {
    super.initState();
    _currentSubject = getSubject();
  }

  Future<Subject> getSubject() async {
    var client = http.Client();
    try {
      var response = await client.get(Uri.https(
          'stoady.herokuapp.com', '/subjects/${Logic.currentSubjectId}'));
      if (response.statusCode == 200) {
        return Subject.fromJsonWithTopics(
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
    if (Logic.currentSubjectId == 0) {
      return Scaffold(
          appBar: AppBar(),
          drawer: const SideMenu(),
          body: Center(
              child: Column(children: [
            const Text(
              'No Group Selected',
            ),
            Image.asset(
              "assets/images/sad.gif",
              height: 125.0,
              width: 125.0,
            ),
          ])));
    }
    return Scaffold(
        appBar: AppBar(),
        drawer: const SideMenu(),
        body: FutureBuilder<Subject>(
            future: _currentSubject,
            builder: (BuildContext context, AsyncSnapshot<Subject> snapshot) {
              if (snapshot.hasData) {
                Logic.currentSubject = snapshot.data!;
                return Center(child: Body(subject: Logic.currentSubject));
              } else if (snapshot.hasError) {
                return const NoInternetWidget();
              } else {
                // By default, show a loading spinner.
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }
}
