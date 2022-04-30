import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stoady/components/text_boxes/manage_boxes/rounded_long.dart';
import 'package:stoady/components/widgets/buttons/rounded_button.dart';
import 'package:stoady/models/logic.dart';

import 'package:http/http.dart' as http;
import 'package:stoady/pages/admin/question_manager/question_manager_screen.dart';
import 'package:stoady/pages/admin/subject_manager/subject_manager_page.dart';
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
                                        "Topic",
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
                                                builder:
                                                    (BuildContext context) =>
                                                        confirmDelete(context));
                                          },
                                          child: const Positioned(
                                              top: 0,
                                              right: 0,
                                              child: Icon(
                                                  Icons.delete_forever_rounded,
                                                  color: Colors.teal,
                                                  size: 35)))))
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
                                    isNew ? '' : Logic.currentTopicInfo.name,
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
                                    : Logic.currentTopicInfo.description,
                              ))),
                      Expanded(
                          child: Align(
                              alignment: Alignment.topLeft,
                              child: Row(children: [
                                const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 5),
                                    child: Text(
                                      "Questions",
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
                                                //TODO:: TOPIC PAGE!!!
                                                onTap: () {
                                                  isNew
                                                      ? showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              title: const Text(
                                                                  "❌ Can't create new question"),
                                                              content: const Text(
                                                                  "You must save topic before adding anything to it."),
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
                                                                  const QuestionManagerPage(
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
            press: () => {Navigator.of(context).pop(false)},
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
                    {addTopic(context)}
                  else
                    {
                      showDialog(
                          //if set to true allow to close popup by tapping out of the popup
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                title: const Text("💾 Nothing to save."),
                                content: const Text(
                                    "You must fill name to save topic."),
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
                {changeTopic(context)}
            },
          ),
          SizedBox(width: size.width * 0.01),
        ]);
  }

  Future<void> changeTopic(BuildContext context) async {
    var client = http.Client();
    final jsonString = json.encode({
      'topicName': _name.isEmpty ? Logic.currentTopicInfo.name : _name,
      'topicDescription': _description.isEmpty
          ? Logic.currentTopicInfo.description
          : _description,
    });
    try {
      var response = await client.post(
          Uri.https(
              'stoady.herokuapp.com', '/topics/edit/${Logic.currentTopicId}'),
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

  Future<void> addTopic(BuildContext context) async {
    print("+++++++++++++++++++++" + _name);
    var client = http.Client();
    final jsonString = json.encode({
      'subjectId': Logic.currentSubjectId,
      'topicName': _name,
      'topicDescription': _description
    });
    try {
      var response = await client.post(
          Uri.https('stoady.herokuapp.com', '/topics/add'),
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
              builder: (context) => const SubjectManagerPage(isNew: false)));
    }
  }

  Future<void> deleteTopic(BuildContext context) async {
    var client = http.Client();
    try {
      var response = await client.delete(Uri.https(
          'stoady.herokuapp.com', '/topics/remove/${Logic.currentTopicId}'));
      if (response.statusCode != 200) {
        // todo handle exception
        throw Exception();
      }
    } finally {
      client.close();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const SubjectManagerPage(isNew: false)));
    }
  }

  AlertDialog confirmDelete(BuildContext context) {
    if (isNew) {
      return AlertDialog(
        title: const Text("❌ Nothing to delete."),
        content: const Text("This topic don't exist yet."),
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
      content: const Text("Are you sure you wish to delete this topic?"),
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
            deleteTopic(context);
            Navigator.of(context).pop(true);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const SubjectManagerPage(isNew: false)));
          },
        )
      ],
    );
  }
}
