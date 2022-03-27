import 'package:flutter/material.dart';
import 'package:stoady/models/logic.dart';
import 'package:stoady/models/member.dart';
import 'package:http/http.dart' as http;
import 'package:stoady/models/role.dart';

class PersonCard extends StatelessWidget {
  const PersonCard({
    Key? key,
    required this.user,
  }) : super(key: key);

  final Member user;

  @override
  Widget build(BuildContext context) {
    //bool userState = Logic.currentGroup.userInfo[user];
    return Dismissible(
        key: Key(user.email),
        confirmDismiss: (DismissDirection direction) async {
          //TODO: check that user is hthe only admin -> no delete.
          if (Logic.members.members.length > 1) {
            showSnackBar(context, user.email);
            removeUser(user.id, context);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('There must be at least one user in the group'),
            ));
            return false;
          }
          return await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Confirm"),
                content: const Text("Are you sure you wish to delete this item?"),
                actions: <Widget>[
                  TextButton(
                    child: const Text('CANCEL'),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                  TextButton(
                    child: const Text('ACCEPT'),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                  )
                ],
              );
            },
          );
        },
        background: deleteBackGroundItem(),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(children: [
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.email,
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(height: 3),
                          ]))),
              Switch(
                value: user.isAdmin(),
                onChanged: (value) {
                  if (!user.isAdmin() ||
                      Logic.members.anyAdmin()) {
                    Logic.members.changeAbility(user);
                    //userState = !userState;
                    (context as Element).reassemble();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content:
                      Text('There must be at least one admin in the group'),
                    ));
                  }
                },
                activeTrackColor: Colors.lightGreen,
                activeColor: Colors.green,
              ),
            ])));
  }

  Widget deleteBackGroundItem() {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20),
      color: Colors.red,
      child: const Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }

  showSnackBar(context, userMail) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('User $userMail deleted')));
  }

  bool confirmDialog(BuildContext context, userMail) {
    bool answer = false;
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Deactivate'),
          content: Text('Delete user $userMail?'),
          actions: <Widget>[
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
                answer =  false;
              },
            ),
            TextButton(
              child: const Text('ACCEPT'),
              onPressed: () {
                Navigator.of(context).pop();
                answer =  true;
              },
            )
          ],
        );
      },
    );
    return answer;
  }
}

Future<void> removeUser(int userId, BuildContext context) async {
  var client = http.Client();
  try {
    var response = await http.delete(
        Uri.https('stoady.herokuapp.com', '/teams/${Logic.currentGroupId}/members/remove', {'userId': userId.toString()}),
        headers: {'executorId': Logic.currentUser.id.toString()});
    Logic.members.members.remove((Logic.members.members).where((element) => element.id == userId).first);
    (context as Element).reassemble();
    if (response.statusCode != 200) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Something went wrong, user wasn't removed.")));
    }
  } finally {
    client.close();
  }
}

Future<void> changeUserRole(int userId, BuildContext context, Role role) async {
  var client = http.Client();
  try {
    var response = await http.put(
        Uri.https('stoady.herokuapp.com', '/teams/${Logic.currentGroupId}/members/', {'userId': userId.toString(), 'userRole': role.toString()}),
        headers: {'executorId': Logic.currentUser.id.toString()});
    Logic.members.members.remove((Logic.members.members).where((element) => element.id == userId).first);
    (context as Element).reassemble();
    if (response.statusCode != 200) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Something went wrong, user wasn't removed.")));
    }
  } finally {
    client.close();
  }
}
