import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stoady/components/text_boxes/manage_boxes/rounded_long.dart';
import 'package:stoady/components/widgets/buttons/rounded_button.dart';
import 'package:stoady/models/logic.dart';

import 'package:http/http.dart' as http;
import 'package:stoady/pages/admin/topic_manager/topic_manager_page.dart';
import 'package:stoady/pages/user/home/home_page.dart';

class Background extends StatelessWidget {
  final Widget child;
  final bool isNew;

  Background({
    Key? key,
    required this.child,
    required this.isNew,
  }) : super(key: key);

  late String _name = '', _description = '';

  @override
  Widget build(BuildContext context) {
    // This size provide us total height and width of our screen
    Size size = MediaQuery.of(context).size;
    return Center(
        child: SingleChildScrollView(
            reverse: false,
            child: Container(
                height: size.height,
                width: size.width,
                child: Stack(children: <Widget>[
                  Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          //SizedBox(height: size.height * 0.2, width: size.width * 0.02),
                          const Expanded(
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 5),
                                      child: Text(
                                        "Subject",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: 30,
                                            color: Colors.teal,
                                            fontWeight: FontWeight.w900),
                                      )))),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Align(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 15),
                                      child: GestureDetector(
                                        onTap: () {
                                          showDialog(
                                              //if set to true allow to close popup by tapping out of the popup
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  confirmDelete(context));
                                        },
                                        child: const Positioned(
                                            top: 0,
                                            right: 0,
                                            child: Icon(
                                                Icons.delete_forever_rounded,
                                                color: Colors.teal,
                                                size: 35)),
                                      )))
                            ],
                          ),
                          //SizedBox(height: size.height * 0.2, width: size.width * 0.02),
                        ],
                      ),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              child: RoundedInputTextField(
                                isQuestion: false,
                                hintText: "Name",
                                onChanged: (value) {
                                  _name = value;
                                },
                                isBig: false,
                                initialValue:
                                    isNew ? '' : Logic.currentSubject.name,
                              ))),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 0),
                              child: RoundedInputTextField(
                                isQuestion: false,
                                hintText: "Description",
                                onChanged: (value) {
                                  _description = value;
                                },
                                isBig: true,
                                initialValue: isNew
                                    ? ''
                                    : Logic.currentSubject.description,
                              ))),
                      Expanded(
                          child: Align(
                              alignment: Alignment.topLeft,
                              child: Row(children: [
                                const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 5),
                                    child: Text(
                                      "Topics",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 30,
                                          color: Colors.teal,
                                          fontWeight: FontWeight.w900),
                                    )),
                                Expanded(
                                    child: Align(
                                        alignment: Alignment.topRight,
                                        child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 5),
                                            child: GestureDetector(
                                                onTap: () {
                                                  isNew
                                                      ? showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              title: const Text(
                                                                  "❌ Can't create new topic"),
                                                              content: const Text(
                                                                  "You must save subject before adding anything to it."),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                  child:
                                                                      const Text(
                                                                          'OK'),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop(
                                                                            false);
                                                                  },
                                                                )
                                                              ],
                                                            );
                                                          })
                                                      : Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const TopicManagerPage(
                                                                      isNew:
                                                                          true)));
                                                },
                                                child: const Icon(
                                                    Icons.add_rounded,
                                                    color: Colors.teal,
                                                    size: 35)))))
                              ]))),
                      child,
                      buttons(size, context, isNew),
                    ],
                  )
                ]))));
  }

  Widget buttons(Size size, BuildContext context, bool isNew) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SizedBox(width: size.width * 0.01),
          RoundedButton(
            borders: true,
            reverse: true,
            isSmall: true,
            text: "Cancel",
            press: () => {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const UserHomePage(showAddButton: true)))
            },
          ),
          SizedBox(width: size.width * 0.005),
          RoundedButton(
            borders: true,
            reverse: false,
            isSmall: true,
            text: "Save",
            press: () => {
              if (isNew)
                {
                  if (_name.isNotEmpty)
                    {addSubject(context)}
                  else
                    {
                      showDialog(
                          //if set to true allow to close popup by tapping out of the popup
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                title: const Text("💾 Nothing to save."),
                                content: const Text(
                                    "You must fill name to save subject."),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('OK'),
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                  )
                                ],
                              ))
                    }
                }
              else
                {changeSubject(context)}
            },
          ),
          SizedBox(width: size.width * 0.01),
        ]);
  }

  Future<void> changeSubject(BuildContext context) async {
    var client = http.Client();
    final jsonString = json.encode({
      'subjectName': _name.isEmpty ? Logic.currentSubject.name : _name,
      'subjectDescription': _description.isEmpty
          ? Logic.currentSubject.description
          : _description,
    });
    try {
      var response = await client.post(
          Uri.https('stoady.herokuapp.com',
              '/subjects/edit/${Logic.currentSubjectId}'),
          headers: {HttpHeaders.contentTypeHeader: 'application/json'},
          body: jsonString);
      if (response.statusCode != 200) {
        // todo handle exception
        throw Exception();
      }
    } finally {
      client.close();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const UserHomePage(showAddButton: true)));
    }
  }

  Future<void> addSubject(BuildContext context) async {
    var client = http.Client();
    final jsonString = json.encode({
      'teamId': Logic.currentGroupId,
      'subjectName': _name,
      'subjectDescription': _description
    });
    try {
      var response = await client.post(
          Uri.https('stoady.herokuapp.com', '/subjects/add'),
          headers: {HttpHeaders.contentTypeHeader: 'application/json'},
          body: jsonString);
      if (response.statusCode != 200) {
        // todo handle exception
        throw Exception();
      }
    } finally {
      client.close();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const UserHomePage(showAddButton: true)));
    }
  }

  Future<void> deleteSubject(BuildContext context) async {
    var client = http.Client();
    try {
      var response = await client.delete(Uri.https('stoady.herokuapp.com',
          '/subjects/remove/${Logic.currentSubjectId}'));
      if (response.statusCode != 200) {
        // todo handle exception
        throw Exception();
      }
    } finally {
      client.close();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const UserHomePage(showAddButton: true)));
    }
  }

  AlertDialog confirmDelete(BuildContext context) {
    if (isNew) {
      return AlertDialog(
        title: const Text("❌ Nothing to delete."),
        content: const Text("This subject don't exist yet."),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          )
        ],
      );
    }
    return AlertDialog(
      title: const Text("✔️Confirm"),
      content: const Text("Are you sure you wish to delete this subject?"),
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
            deleteSubject(context);
            Navigator.of(context).pop(true);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const UserHomePage(showAddButton: true)));
          },
        )
      ],
    );
  }
}
