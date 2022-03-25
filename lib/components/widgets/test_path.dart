import 'package:flutter/cupertino.dart';
import 'package:stoady/models/logic.dart';
import 'package:flutter/material.dart';

class TestPath extends StatelessWidget {
  final bool isTest;

  const TestPath({Key? key, required this.isTest}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(children: <Widget>[
      SizedBox(height: size.height * (isTest ? 0.05 : 0.1), width: size.width),
      Text(
        Logic.currentSubject.name,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 26, color: Colors.black54, fontWeight: FontWeight.w900),
      ),
      Text(
        Logic.currentTopicInfo.name,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 22, color: Colors.black54, fontWeight: FontWeight.w700),
      ),
    ]);
  }
}
