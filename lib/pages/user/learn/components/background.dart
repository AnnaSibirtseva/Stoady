import 'package:flutter/material.dart';
import 'package:stoady/models/logic.dart';
import 'package:stoady/pages/user/learn/components/card.dart';

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
              savedStar(size, context),
            ]),
            Column(children: <Widget>[
              SizedBox(height: size.height * 0.2, width: size.width),
              Image.asset('assets/images/learning_toad.png',
                  width: size.width * 0.13)
            ]),
            testPath(size),
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
              child,
            ]),
            questionsCounter(size),
          ])),
    );
  }
}

Widget savedStar(Size size, BuildContext context) {
  if(Logic.currentUser.isSaved(Logic.currentTopic.test.questions[Logic.currentIndex])) {
    return GestureDetector(
        onTap: () => {
          (context as Element).reassemble(),
          Logic.currentUser.removeTask(Logic
              .currentTopic.test.questions[Logic.currentIndex]),
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
        Logic.currentUser.addTask(Logic
            .currentTopic.test.questions[Logic.currentIndex]),
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

Widget testPath(Size size) {
  return Column(children: <Widget>[
    SizedBox(height: size.height * 0.1, width: size.width),
    Text(
      Logic.currentTopic.getSubjectName(),
      textAlign: TextAlign.center,
      style: const TextStyle(
          fontSize: 26,
          color: Colors.black54,
          fontWeight: FontWeight.w900),
    ),
    Text(
      Logic.currentTopic.getTitle(),
      textAlign: TextAlign.center,
      style: const TextStyle(
          fontSize: 22,
          color: Colors.black54,
          fontWeight: FontWeight.w700),
    ),
  ]);
}

Widget questionsCounter(Size size) {
  return Column(children: <Widget>[
    SizedBox(height: size.height * 0.78, width: size.width),
    Text(
      (Logic.currentIndex + 1).toString() +
          "/" +
          Logic.currentTopic.test.questions.length.toString(),
      textAlign: TextAlign.center,
      style: const TextStyle(
          fontSize: 22,
          color: Colors.black45,
          fontWeight: FontWeight.w700),
    ),
  ]);
}
