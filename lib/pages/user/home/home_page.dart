import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stoady/components/widgets/empty.dart';
import 'package:stoady/components/widgets/no_internet.dart';
import 'package:stoady/components/widgets/side_menu.dart';
import 'package:stoady/models/group.dart';
import 'package:stoady/models/logic.dart';
import 'package:http/http.dart' as http;
import 'package:stoady/pages/user/home/components/body.dart';

class UserHomePage extends StatefulWidget {
  final bool showAddButton;

  const UserHomePage({Key? key, required this.showAddButton}) : super(key: key);

  @override
  State<UserHomePage> createState() => _UserHomePageState(showAddButton);
}

class _UserHomePageState extends State<UserHomePage> {
  bool showAddButton;
  late Future<Group> _futureCurrentGroup;

  _UserHomePageState(this.showAddButton);

  @override
  void initState() {
    super.initState();
    _futureCurrentGroup = getGroup();
  }

  Future<Group> getGroup() async {
    var client = http.Client();
    try {
      var response = await client.get(
          Uri.https('stoady.herokuapp.com', '/teams/${Logic.currentGroupId}'));
      if (response.statusCode == 200) {
        return Group.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
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
    if (Logic.currentGroupId == -1) {
      return const NothingFoundWidget(text: 'No Group Selected');
    }
    return Scaffold(
        appBar: AppBar(),
        drawer: const SideMenu(),
        body: FutureBuilder<Group>(
            future: _futureCurrentGroup,
            builder: (BuildContext context, AsyncSnapshot<Group> snapshot) {
              if (snapshot.hasData) {
                Logic.currentGroup = snapshot.data!;
                Logic.allSubjects = Logic.currentGroup.subjects;
                return Center(child: Body(showAddButton: showAddButton));
              } else if (snapshot.hasError) {
                return const NoInternetWidget();
              } else {
                // By default, show a loading spinner.
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }
}
