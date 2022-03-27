import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stoady/components/widgets/empty.dart';
import 'package:stoady/components/widgets/no_internet.dart';
import 'package:stoady/components/widgets/side_menu.dart';
import 'package:stoady/models/logic.dart';
import 'package:stoady/models/member.dart';
import 'package:stoady/models/team_members.dart';
import 'package:stoady/pages/admin/admin_mode/components/body.dart';
import 'package:http/http.dart' as http;

class AdminModePage extends StatefulWidget {
  const AdminModePage({Key? key}) : super(key: key);

  @override
  State<AdminModePage> createState() => _AdminModePage();
}

class _AdminModePage extends State<AdminModePage> {
  late Future<List<Member>> _futureList;

  @override
  void initState() {
    super.initState();
    _futureList = getMembers();
  }

  Future<List<Member>> getMembers() async {
    var client = http.Client();
    try {
      var response = await client.get(Uri.https(
          'stoady.herokuapp.com', '/teams/${Logic.currentGroupId}/members'));
      if (response.statusCode == 200) {
        return TeamMembers.fromJson(jsonDecode(utf8.decode(response.bodyBytes)))
            .members;
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
        body: FutureBuilder<List<Member>>(
            future: _futureList,
            builder:
                (BuildContext context, AsyncSnapshot<List<Member>> snapshot) {
              if (snapshot.hasData) {
                Logic.members.members = snapshot.data!;
                return const Center(
                    child:
                        SingleChildScrollView(reverse: false, child: Body()));
              } else if (snapshot.hasError) {
                return const NoInternetWidget();
              } else {
                // By default, show a loading spinner.
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }
}
