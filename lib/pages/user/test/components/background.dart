import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stoady/components/text_boxes/answer_text_field.dart';
import 'package:stoady/components/text_boxes/rounded_input.dart';
import 'package:stoady/components/widgets/buttons/rounded_button.dart';
import 'package:stoady/components/widgets/question_counter.dart';
import 'package:stoady/components/widgets/saved_star.dart';
import 'package:stoady/components/widgets/test_path.dart';
import 'package:stoady/models/logic.dart';
import 'package:stoady/models/question.dart';
import 'package:stoady/pages/user/learn/components/card.dart';
import 'package:http/http.dart' as http;

class Background extends StatelessWidget {
  final Widget child;
  final bool isSaved;
  late String currentAnswer = "";
  late Map<Question, int> points = {};
  late int totalScore = 1;

  Background({
    Key? key,
    required this.child,
    required this.isSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LearningCard.isTestingCard = true;
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      child: SingleChildScrollView(
          reverse: true,
          child: Stack(
              //alignment: Alignment.center,
              children: <Widget>[
                Row(children: <Widget>[
                  SizedBox(
                      height: size.height * 0.08, width: size.width * 0.85),
                  const SavedStar(),
                ]),
                Column(children: <Widget>[
                  SizedBox(height: size.height * 0.17, width: size.width),
                  Image.asset('assets/images/learning_toad.png',
                      width: size.width * 0.13)
                ]),
                isSaved
                    ? Column(children: <Widget>[
                  SizedBox(
                      height: size.height * (0.1),
                      width: size.width),
                  const Text(
                    "Saved Questions",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 26,
                        color: Colors.black54,
                        fontWeight: FontWeight.w900),
                  )
                ])
                    :const TestPath(isTest: true),
                Row(
                  children: <Widget>[
                    SizedBox(height: size.height * 1),
                    GestureDetector(
                      onTap: () => {
                        Logic.addIndex(false),
                        LearningCard.showFrontSide = true,
                        AnswerTextFieldContainer.currentState =
                            AnswerState.empty,
                        (context as Element).reassemble()
                      }, // Image tapped
                      child: Image.asset('assets/images/left_arrow.png',
                          width: size.width * 0.15),
                    ),
                    SizedBox(width: size.width * 0.7),
                    GestureDetector(
                      onTap: () => {
                        Logic.addIndex(true),
                        LearningCard.showFrontSide = true,
                        AnswerTextFieldContainer.currentState =
                            AnswerState.empty,
                        (context as Element).reassemble()
                      }, // Image tapped
                      child: Image.asset('assets/images/right_arrow.png',
                          width: size.width * 0.15),
                    ),
                  ],
                ),
                Column(children: <Widget>[
                  SizedBox(height: size.height * 0.235),
                  const LearningCard(),
                  const QuestionCounter(isTest: true),
                  RoundedInputField(
                    hintText: "Answer",
                    onChanged: (value) {
                      currentAnswer = value;
                    },
                    icon: Icons.add,
                    isSmall: true,
                    isAnswer: true,
                  ),
                  RoundedButton(
                      borders: false,
                      reverse: false,
                      isSmall: true,
                      text: "Submit",
                      press: () => {
                            if (currentAnswer.isNotEmpty)
                              {
                                if (currentAnswer ==
                                    Logic.questions[Logic.currentIndex]
                                        .answerText)
                                  {
                                    AnswerTextFieldContainer.currentState =
                                        AnswerState.correct,
                                    points[
                                        Logic.questions[Logic.currentIndex]] = 1
                                  }
                                else
                                  {
                                    AnswerTextFieldContainer.currentState =
                                        AnswerState.wrong,
                                    points[
                                        Logic.questions[Logic.currentIndex]] = 0
                                  },
                                saveResults(calcResult()),
                              }
                            else
                              {
                                AnswerTextFieldContainer.currentState =
                                    AnswerState.empty
                              },
                            (context as Element).reassemble(),
                          }),
                  child,
                ]),
              ])),
    );
  }

  int calcResult() {
    int score = 0;
    for (var point in points.values) {
      score += point;
    }
    return (score * 100) ~/ Logic.questions.length;
  }

  Future<void> saveResults(int newResult) async {
    var client = http.Client();
    final jsonString = json.encode({
      'userId': Logic.currentUser.id,
      'topicId': Logic.currentTopicId,
      'result': newResult
    });
    try {
      var response = await client.post(
          Uri.https('stoady.herokuapp.com', '/tests'),
          headers: {HttpHeaders.contentTypeHeader: 'application/json'},
          body: jsonString);
      if (response.statusCode != 200) {
        // todo handle exception
        throw Exception();
      }
    } finally {
      client.close();
    }
  }
}
