import 'package:flutter/material.dart';
import 'package:stoady/components/widgets/question_counter.dart';
import 'package:stoady/components/widgets/saved_star.dart';
import 'package:stoady/components/widgets/test_path.dart';
import 'package:stoady/models/logic.dart';
import 'package:stoady/pages/user/learn/components/card.dart';
import 'package:stoady/pages/user/learn/learn_page.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    LearningCard.isTestingCard = false;
    return Container(
      height: size.height,
      width: size.width,
      child: SingleChildScrollView(
          child: Stack(
              //alignment: Alignment.center,
              children: <Widget>[
            Row(children: <Widget>[
              SizedBox(height: size.height * 0.08, width: size.width * 0.85),
              const SavedStar(),
            ]),
            Column(children: <Widget>[
              SizedBox(height: size.height * 0.2, width: size.width),
              Image.asset('assets/images/learning_toad.png',
                  width: size.width * 0.13)
            ]),
            LearningPage.isSaved
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
                : const TestPath(isTest: true),
            Row(
              children: <Widget>[
                SizedBox(height: size.height * 1),
                GestureDetector(
                  onTap: () => {
                    Logic.addIndex(false),
                    LearningCard.showFrontSide = true,
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
                    (context as Element).reassemble()
                  }, // Image tapped
                  child: Image.asset('assets/images/right_arrow.png',
                      width: size.width * 0.15),
                ),
              ],
            ),
            Column(children: <Widget>[
              SizedBox(height: size.height * 0.265),
              const LearningCard(),
              const QuestionCounter(isTest: true),
              child,
            ]),
          ])),
    );
  }
}
