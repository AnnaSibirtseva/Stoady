import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stoady/components/text_boxes/manage_boxes/rounded_long.dart';
import 'package:stoady/components/widgets/buttons/rounded_button.dart';
import 'package:stoady/models/logic.dart';

import 'package:http/http.dart' as http;
import 'package:stoady/pages/admin/topic_manager/topic_manager_page.dart';

class Background extends StatelessWidget {
  final bool isNew;
  Background({
    Key? key,
    required this.isNew,
  }) : super(key: key);

  late String _questionText = '', _answerText = '';

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
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                        "Question",
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
                                hintText: "Question",
                                onChanged: (value) {
                                  _questionText = value;
                                },
                                isBig: true,
                                initialValue: isNew
                                    ? ''
                                    : Logic
                                        .currentTopicInfo
                                        .questions[Logic.currentIndex]
                                        .questionText,
                                isQuestion: true,
                              ))),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 0),
                              child: RoundedInputTextField(
                                isQuestion: true,
                                hintText: "Answer",
                                onChanged: (value) {
                                  _answerText = value;
                                },
                                isBig: true,
                                initialValue: isNew
                                    ? ''
                                    : Logic
                                        .currentTopicInfo
                                        .questions[Logic.currentIndex]
                                        .answerText,
                              ))),
                      SizedBox(height: size.height * 0.1),
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
                  if (_questionText.isNotEmpty && _answerText.isNotEmpty)
                    {addQuestion(context)}
                  else
                    {
                      showDialog(
                          //if set to true allow to close popup by tapping out of the popup
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                title: const Text("Wrong question"),
                                content: const Text(
                                    "You have to fill in both fields to create a new question"),
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
                {changeQuestion(context)}
            },
          ),
          SizedBox(width: size.width * 0.01),
        ]);
  }

  Future<void> changeQuestion(BuildContext context) async {
    var client = http.Client();
    final jsonString = json.encode({
      'questionText': _questionText.isEmpty
          ? Logic.currentTopicInfo.questions[Logic.currentIndex].questionText
          : _questionText,
      'answerText': _answerText.isEmpty
          ? Logic.currentTopicInfo.questions[Logic.currentIndex].questionText
          : _answerText,
    });
    try {
      var response = await client.post(
          Uri.https('stoady.herokuapp.com',
              '/questions/edit/${Logic.currentTopicInfo.questions[Logic.currentIndex].id}'),
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
              builder: (context) => const TopicManagerPage(isNew: false)));
    }
  }

  Future<void> addQuestion(BuildContext context) async {
    var client = http.Client();
    final jsonString = json.encode({
      'topicId': Logic.currentTopicId,
      'questionText': _questionText,
      'answerText': _answerText
    });
    try {
      var response = await client.post(
          Uri.https('stoady.herokuapp.com', '/questions/add'),
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
              builder: (context) => const TopicManagerPage(isNew: false)));
    }
  }

  Future<void> deleteQuestion(BuildContext context) async {
    var client = http.Client();
    try {
      var response = await client.delete(Uri.https('stoady.herokuapp.com',
          '/questions/remove/${Logic.currentTopicInfo.questions[Logic.currentIndex].id}'));
      if (response.statusCode != 200) {
        // todo handle exception
        throw Exception();
      }
    } finally {
      client.close();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const TopicManagerPage(isNew: false)));
    }
  }

  AlertDialog confirmDelete(BuildContext context) {
    if (isNew) {
      return AlertDialog(
        title: const Text("Nothing to delete."),
        content: const Text("This question don't exist yet."),
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
      title: const Text("Confirm"),
      content: const Text("Are you sure you wish to delete this question?"),
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
            deleteQuestion(context);
            Navigator.of(context).pop(true);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const TopicManagerPage(isNew: false)));
          },
        )
      ],
    );
  }
}
