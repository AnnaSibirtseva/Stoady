import 'package:flutter/material.dart';
import 'package:stoady/components/text_boxes/answer_text_field.dart';
import 'package:stoady/components/text_boxes/rounded_input.dart';
import 'package:stoady/components/widgets/buttons/rounded_button.dart';
import 'package:stoady/components/widgets/question_counter.dart';
import 'package:stoady/components/widgets/question_counter.dart';
import 'package:stoady/components/widgets/test_path.dart';
import 'package:stoady/models/logic.dart';
import 'package:stoady/pages/user/learn/components/card.dart';

class Background extends StatelessWidget {
  final Widget child;
  late String currentAnswer = "";

  Background({
    Key? key,
    required this.child,
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
                  savedStar(size, context),
                ]),
                Column(children: <Widget>[
                  SizedBox(height: size.height * 0.17, width: size.width),
                  Image.asset('assets/images/learning_toad.png',
                      width: size.width * 0.13)
                ]),
                const TestPath(isTest: true),
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
                                    // Logic.addIndex(true),
                                    // (context as Element).reassemble(),
                                    // AnswerTextFieldContainer.currentState =
                                    //     AnswerState.empty
                                  }
                                else
                                  {
                                    AnswerTextFieldContainer.currentState =
                                        AnswerState.wrong
                                  }
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
}

Widget savedStar(Size size, BuildContext context) {
  if (Logic.currentUser
      .isSaved(Logic.currentTopic.test.questions[Logic.currentIndex])) {
    return GestureDetector(
        onTap: () => {
              (context as Element).reassemble(),
              Logic.currentUser.removeTask(
                  Logic.currentTopic.test.questions[Logic.currentIndex]),
              savedStar(size, context)
            },
        child: Positioned(
          top: 0,
          right: 0,
          child: Image.asset(
            "assets/images/saved_empty.png",
            width: size.width * 0.09,
          ),
        ));
  }
  return GestureDetector(
      onTap: () => {
            (context as Element).reassemble(),
            Logic.currentUser
                .addTask(Logic.currentTopic.test.questions[Logic.currentIndex]),
            savedStar(size, context)
          },
      child: Positioned(
        top: 0,
        right: 0,
        child: Image.asset(
          "assets/images/saved_filled.png",
          width: size.width * 0.09,
        ),
      ));
}
