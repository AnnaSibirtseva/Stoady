import 'package:flutter/material.dart';
import 'package:stoady/components/text_boxes/password_input.dart';
import 'package:stoady/components/text_boxes/rounded_input.dart';
import 'package:stoady/components/widgets/already_have_account.dart';
import 'package:stoady/components/widgets/buttons/rounded_button.dart';
import 'package:stoady/models/logic.dart';
import 'package:stoady/pages/user/group/group_page.dart';
import 'background.dart';

class Body extends StatelessWidget {
  static const int minName = 2;
  static const int maxName = 30;
  static const int minMail = 7;
  static const int maxMail = 100;
  static const int minPassword = 8;
  static const int maxPassword = 30;

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
              press: () => {
                    if (Logic.registerInfo.userName.length < minName ||
                        Logic.registerInfo.userName.length > maxName)
                      {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                "The name must be between 2 and 30 characters.")))
                      }
                    else if (Logic.registerInfo.email.length < minMail ||
                        Logic.registerInfo.email.length > maxMail)
                      {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                "The e-mail must be between 7 and 100 characters.")))
                      }
                    else if (Logic.registerInfo.password.length < minPassword ||
                        Logic.registerInfo.password.length > maxPassword)
                      {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                "The password must be between 8 and 30 characters.")))
                      }
                    else
                      {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const GroupPage(fromLogIn: false)))
                      }
                  }),
          SizedBox(height: size.height * 0.01),
          const AlreadyHaveAnAccountCheck(login: false)
        ],
      ),
    )));
  }
}
