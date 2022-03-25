import 'package:flutter/cupertino.dart';
import 'package:stoady/models/logic.dart';
import 'package:flutter/material.dart';

class QuestionCounter extends StatelessWidget {
  final bool isTest;
  const QuestionCounter({Key? key, required this.isTest}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(children: <Widget>[
      SizedBox(height: size.height * (isTest ? 0.01 : 0.1), width: size.width),
      Text(
        (Logic.currentIndex + 1).toString() +
            "/" +
            Logic.questions.length.toString(),
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 22, color: Colors.black45, fontWeight: FontWeight.w700),
      ),
    ]);
  }
}
