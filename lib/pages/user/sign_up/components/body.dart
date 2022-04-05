import 'package:flutter/material.dart';
import 'package:stoady/components/text_boxes/password_input.dart';
import 'package:stoady/components/text_boxes/rounded_input.dart';
import 'package:stoady/components/widgets/already_have_account.dart';
import 'package:stoady/components/widgets/buttons/rounded_button.dart';
import 'package:stoady/models/logic.dart';
import 'package:stoady/pages/user/group/group_page.dart';
import 'package:stoady/pages/user/home/home_page.dart';
import 'background.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
        body: Center(
            child: SingleChildScrollView(
      reverse: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: size.height * 0.03),
          Positioned(
              child: Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/logo.png",
                    width: size.width * 0.6,
                  ))),
          SizedBox(height: size.height * 0.03),
          RoundedInputField(
            hintText: "Name",
            icon: Icons.person_outline_rounded,
            onChanged: (value) {
              Logic.registerInfo.userName = value;
            },
            isSmall: false,
            isAnswer: false,
          ),
          RoundedInputField(
            hintText: "E-mail",
            onChanged: (value) {
              Logic.registerInfo.email = value;
            },
            icon: Icons.email_outlined,
            isSmall: false,
            isAnswer: false,
          ),
          RoundedPasswordField(
            onChanged: (value) {
              Logic.registerInfo.password = value;
            },
          ),
          SizedBox(height: size.height * 0.03),
          RoundedButton(
              reverse: false,
              borders: false,
              isSmall: false,
              text: "SIGN UP",
              //TODO: change to normal page!!!
              press: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const GroupPage(fromLogIn: false)))),
          SizedBox(height: size.height * 0.01),
          const AlreadyHaveAnAccountCheck(login: false)
        ],
      ),
    )));
  }
}
