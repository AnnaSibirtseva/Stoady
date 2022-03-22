import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stoady/models/logic.dart';

class LearningCard extends StatefulWidget {
  static bool showFrontSide = true;
  static bool isTestingCard = false;

  const LearningCard({
    Key? key,
  }) : super(key: key);

  @override
  State<LearningCard> createState() => _Card();
}

class _Card extends State<LearningCard> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      constraints:
          BoxConstraints.tight(Size(size.width * 0.65, size.height * 0.5)),
      child: _buildFlipAnimation(),
    );
  }

  Widget _buildFlipAnimation() {
    return GestureDetector(
      onTap: () => {
        if (!LearningCard.isTestingCard)
          {
            setState(
                () => LearningCard.showFrontSide = !LearningCard.showFrontSide)
          }
      },
      child: AnimatedSwitcher(
        transitionBuilder: __transitionBuilder,
        duration: const Duration(milliseconds: 300),
        child: LearningCard.showFrontSide ? _buildFront() : _buildRear(),
      ),
    );
  }

  Widget __transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isUnder = (ValueKey(LearningCard.showFrontSide) != widget!.key);
        final value =
            isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
        return Transform(
          transform: Matrix4.rotationY(value),
          child: widget,
          alignment: Alignment.center,
        );
      },
    );
  }

  Widget _buildFront() {
    return __buildLayout(
      key: const ValueKey(true),
      backgroundColor: Colors.white,
      faceName:
          Logic.questions[Logic.currentIndex].questionText,
    );
  }

  Widget _buildRear() {
    return __buildLayout(
      key: const ValueKey(false),
      backgroundColor: Colors.white,
      faceName:
          Logic.questions[Logic.currentIndex].answerText,
    );
  }

  Widget __buildLayout(
      {required Key key,
      required String faceName,
      required Color backgroundColor}) {
    return Container(
      key: key,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border.all(width: 2),
        borderRadius: BorderRadius.circular(20.0),
        color: backgroundColor,
      ),
      child: Center(
        child: Text(
          faceName,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 22, color: Colors.black, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
