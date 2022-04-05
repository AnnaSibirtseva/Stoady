import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stoady/components/text_boxes/rounded_input.dart';
import 'package:http/http.dart' as http;
import 'package:stoady/models/logic.dart';
import 'package:stoady/pages/user/group/group_page.dart';

import 'background.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String groupName = "New Team";
    return Background(
        child: Center(
            child: Column(children: <Widget>[
      SizedBox(height: size.height * 0.87),
      Row(
        children: [
          SizedBox(width: size.width * 0.09),
          Align(
              alignment: FractionalOffset.bottomLeft,
              child: RoundedInputField(
                hintText: "Group Name",
                onChanged: (value) {
                  groupName = value;
                },
                icon: Icons.groups_rounded,
                isSmall: true,
                isAnswer: false,
              )),
          SizedBox(width: size.width * 0.05),
          FloatingActionButton(
            onPressed: () async {
              var client = http.Client();
              try {
                var response = await http.post(Uri.https(
                    'stoady.herokuapp.com', '/teams/create', {
                  'teamName': groupName,
                  'userId': Logic.currentUser.getId().toString()
                }));
                if (response.statusCode == 200) {
                  // Rebuilding page with groups.
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => const GroupPage(fromLogIn: false)));
                } else {
                  // todo handle exception
                  throw Exception();
                }
              } finally {
                client.close();
              }
            },
            child: const Icon(Icons.add_rounded, size: 35),
          )
        ],
      )
    ])));
  }
}
