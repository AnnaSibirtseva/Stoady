import 'package:flutter/material.dart';
import 'package:stoady/models/question.dart';
import 'package:stoady/models/result.dart';
import 'package:stoady/models/topic_info.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    Key? key,
    required this.question,
    required this.press,
  }) : super(key: key);

  final Question question;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
        onTap: press,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(children: [
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 7),
                      child: Text(
                        question.questionText,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w700),
                      ))),
              Expanded(
                  child: Align(
                      alignment: Alignment.topRight,
                      child: Image.asset('assets/images/right_arrow.png',
                          width: size.width * 0.1)))
            ])));
  }
}
