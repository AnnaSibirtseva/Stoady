import 'package:flutter/material.dart';
import 'package:stoady/components/text_boxes/answer_text_field.dart';
import 'package:stoady/components/widgets/buttons/rounded_button.dart';
import 'package:stoady/models/topic.dart';

import 'background.dart';

class Body extends StatelessWidget {
  final Topic currentTopic;

  const Body({Key? key, required this.currentTopic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Background(
      currentTopic: currentTopic,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.53),
            Row(children: <Widget>[
              SizedBox(width: size.width * 0.1),
              RoundedButton(
                borders: false,
                reverse: false,
                isSmall: true,
                text: "Learn",
                press: () => {},
              ),
              SizedBox(width: size.width * 0.035),
              RoundedButton(
                borders: false,
                reverse: false,
                isSmall: true,
                text: "Test",
                press: () => {AnswerTextFieldContainer.currentState = AnswerState.empty,},
              )
            ])
          ]),
    );
  }
}
