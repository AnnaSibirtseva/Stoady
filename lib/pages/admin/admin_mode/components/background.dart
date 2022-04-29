import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:http/http.dart' as http;

import 'package:stoady/models/logic.dart';
import 'package:stoady/models/member.dart';
import 'package:stoady/models/role.dart';
import 'package:stoady/pages/admin/admin_mode/components/person_card.dart';

import '../admin_mode_page.dart';
import '../filter.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _name = '', _avatar = '';
    // This size provide us total height and width of our screen
    Size size = MediaQuery.of(context).size;
    return SizedBox(
        height: size.height,
        width: double.infinity,
        child: Stack(children: <Widget>[
          Align(
              alignment: Alignment.topRight,
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const AlertDialog(
                              title: Text("INFO"),
                              content: Text(
                                  " - To change the group name or avatar, click on the group name\n\n"
                                  " - To remove a user from the group, swipe their email to the left\n"),
                            );
                          });
                    },
                    child: const Positioned(
                        top: 0,
                        right: 0,
                        child: Icon(Icons.info_outline_rounded,
                            color: Colors.teal, size: 28)),
                  ))),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(width: size.width * 0.02),
              Positioned(
                  child: Image.asset(
                "assets/images/cattail.png",
                width: size.width * 0.13,
              )),
              GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (newContext) {
                        return AlertDialog(
                          title: const Text('🔧 Group Settings'),
                          content: Container(
                              height: 150,
                              child: Column(
                                children: [
                                  TextFormField(
                                    initialValue: Logic.currentGroup.name,
                                    onChanged: (value) {
                                      _name = value;
                                    },
                                    decoration: const InputDecoration(
                                        helperText: "New Group Name"),
                                  ),
                                  //const SizedBox(height: 100, width: 100,),
                                  TextFormField(
                                    initialValue: Logic.currentGroup.picture,
                                    onChanged: (value) {
                                      _avatar = value;
                                    },
                                    decoration: const InputDecoration(
                                        helperText: "New Group Avatar Link"),
                                  ),
                                ],
                              )),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('CANCEL'),
                              onPressed: () {
                                Navigator.pop(newContext);
                              },
                            ),
                            TextButton(
                              child: const Text('SAVE'),
                              onPressed: () async {
                                Navigator.pop(newContext);
                                changeNameAndAvatar(context, _name, _avatar);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text(Logic.currentGroup.getName(),
                      style: const TextStyle(
                          fontSize: 32.0, fontWeight: FontWeight.w900))),
              Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(math.pi),
                child: Image.asset(
                  "assets/images/cattail.png",
                  width: size.width * 0.13,
                ),
              ),
              SizedBox(height: size.height * 0.15, width: size.width * 0.02),
            ],
          ),
          Column(children: <Widget>[
            SizedBox(height: size.height * 0.27, width: size.width * 0.44),
            const Text("Members:",
                //textAlign: TextAlign.left,
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w900)),
          ]),
          Column(
            children: [
              SizedBox(height: size.height * 0.4),
              Expanded(
                  child: ListView.builder(
                      itemCount: Logic.members.members.length,
                      itemBuilder: (context, index) =>
                          buildItem(context, index))),
              SizedBox(height: size.height * 0.2),
            ],
          ),
          child,
        ]));
  }

  Widget buildItem(BuildContext context, int index) {
    Member curUser = Logic.members.members.elementAt(index);
    if (Filter.getBool("admin")) {
      if (curUser.role == Role.Creator) {
        return PersonCard(user: curUser, isCreator: true);
      }
      if (Logic.members.members
          .where((element) => element.id == curUser.id)
          .first
          .isAdmin()) {
        return PersonCard(user: curUser, isCreator: false);
      }
    }
    if (Filter.getBool("student")) {
      if (!(Logic.members.members
          .where((element) => element.id == curUser.id)
          .first
          .isAdmin())) {
        return PersonCard(user: curUser, isCreator: false);
      }
    }
    // Костыль, потому что надо возвращать виджет.
    return const Visibility(
      child: Text("Invisible", style: TextStyle(fontSize: 0)),
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      visible: false,
    );
  }
}

Future<void> changeNameAndAvatar(
    BuildContext context, String name, String avatar) async {
  var client = http.Client();
  final jsonString = json.encode({
    'teamName': name.isEmpty ? Logic.currentGroup.name : name,
    'teamAvatar': avatar.isEmpty ? Logic.currentGroup.picture : avatar,
  });
  try {
    var response = await client.post(
        Uri.https(
            'stoady.herokuapp.com', '/teams/${Logic.currentGroupId}/avatar'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'executorId': Logic.currentUser.id.toString()
        },
        body: jsonString);
    if (response.statusCode == 200) {
      Logic.currentGroup.name = name.isEmpty ? Logic.currentGroup.name : name;
      Logic.currentGroup.picture =
          avatar.isEmpty ? Logic.currentGroup.picture : avatar;
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const AdminModePage()));
    } else {
      // todo handle exception
      throw Exception();
    }
  } finally {
    client.close();
  }
}
