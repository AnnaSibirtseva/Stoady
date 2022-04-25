import 'package:flutter/material.dart';
import 'package:stoady/components/text_boxes/answer_text_field.dart';
import 'package:stoady/components/widgets/buttons/rounded_button.dart';
import 'package:stoady/pages/user/learn/learn_page.dart';
import 'package:stoady/pages/user/test/test_page.dart';

import 'background.dart';

class Body extends StatelessWidget {

  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Background(
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
                // TODO add learn page
                press: () => {
                  LearningPage.isSaved = true,
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LearningPage()))},
              ),
              SizedBox(width: size.width * 0.05),
              RoundedButton(
                borders: false,
                reverse: false,
                isSmall: true,
                //TODO add test page
                text: "Test",
                press: () => {AnswerTextFieldContainer.currentState = AnswerState.empty,
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TestingPage(isSaved: true)))},
              )
            ])
          ]),
    );
  }
}
