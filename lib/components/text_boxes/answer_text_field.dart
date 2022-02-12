import 'package:flutter/material.dart';

enum AnswerState { empty, correct, wrong }

class AnswerTextFieldContainer extends StatelessWidget {
  static AnswerState currentState = AnswerState.empty;
  final Widget child;
  final bool isSmall;

  const AnswerTextFieldContainer({
    Key? key,
    required this.child,
    required this.isSmall,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding:
      EdgeInsets.symmetric(horizontal: 20, vertical: isSmall ? 0.7 : 5),
      width: isSmall ? size.width * 0.6 : size.width * 0.8,
      decoration: BoxDecoration(
          color: currentState != AnswerState.empty
              ? (currentState == AnswerState.correct
              ? const Color.fromRGBO(144, 238, 144, 0.8)
              : const Color.fromRGBO(255, 43, 43, 0.5))
              : Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
              color: currentState != AnswerState.empty
                  ? (currentState == AnswerState.correct
                  ? Colors.green
                  : Colors.red)
                  : Colors.teal)),
      child: child,
    );
  }
}
