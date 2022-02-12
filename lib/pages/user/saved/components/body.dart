import 'package:flutter/material.dart';
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
              SizedBox(width: size.height * 0.05),
              RoundedButton(
                borders: false,
                reverse: false,
                isSmall: true,
                text: "Learn",
                // TODO add learn page
                press: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LearningPage(/*currentTopic: Logic.currentUser.saved*/))),
              ),
              SizedBox(width: size.height * 0.02),
              RoundedButton(
                borders: false,
                reverse: false,
                isSmall: true,
                //TODO add test page
                text: "Test",
                press: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TestingPage())),
              )
            ])
          ]),
    );
  }
}
