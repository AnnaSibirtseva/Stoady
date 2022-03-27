import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stoady/components/widgets/no_internet.dart';
import 'package:stoady/components/widgets/side_menu.dart';
import 'package:http/http.dart' as http;
import 'package:stoady/models/group_members.dart';
import 'package:stoady/models/logic.dart';
import 'package:stoady/models/user.dart';
import 'package:stoady/models/user_group.dart';
import 'package:stoady/pages/user/group/components/body.dart';

class GroupPage extends StatefulWidget {
  const GroupPage({
    Key? key,
  }) : super(key: key);

  @override
  _GroupPageState createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  late Future<List<UserGroup>> _futureList;
  late Future<User> _futureUser;

  @override
  void initState() {
    super.initState();
    _futureList = getUserGroups();
    _futureUser = getUser();
  }

  Future<List<UserGroup>> getUserGroups() async {
    var client = http.Client();
    try {
      var response = await client.get(Uri.https('stoady.herokuapp.com',
          '/users/teams', {'userId': Logic.currentUser.getId().toString()}));
      if (response.statusCode == 200) {
        return GroupMembers.fromJson(
                jsonDecode(utf8.decode(response.bodyBytes)))
            .members;
      } else {
        // todo handle exception
        throw Exception();
      }
    } finally {
      client.close();
    }
  }

  Future<User> getUser() async {
    var client = http.Client();
    final jsonString = json.encode(
        {'email': Logic.userInfo.email, 'password': Logic.userInfo.password});
    try {
      var response = await client.post(
          Uri.https('stoady.herokuapp.com', '/auth/authorize'),
          headers: {HttpHeaders.contentTypeHeader: 'application/json'},
          body: jsonString);
      if (response.statusCode == 200) {
        return User.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
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
        body: FutureBuilder<User>(
            future: _futureUser,
            builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
              if (snapshot.hasData) {
                Logic.currentUser = snapshot.data!;
                Logic.currentUser.setMailPassword(Logic.userInfo);
                return FutureBuilder<List<UserGroup>>(
                    future: getUserGroups(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<UserGroup>> snapshot) {
                      if (snapshot.hasData) {
                        Logic.userGroups = snapshot.data!;
                        return const Center(
                            child: SingleChildScrollView(
                                reverse: true, child: Body()));
                      } else if (snapshot.hasError) {
                        return const NoInternetWidget();
                      } else {
                        // By default, show a loading spinner.
                        return const Center(child: CircularProgressIndicator());
                      }
                    });
              } else if (snapshot.hasError) {
                return AlertDialog(
                  title: const Text("Authorization Failed."),
                  content: const Text("Please check your email and password."),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                    )
                  ],
                );
              } else {
                // By default, show a loading spinner.
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }
}
