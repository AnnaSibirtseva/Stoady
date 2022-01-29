import 'package:flutter/material.dart';
import 'package:stoady/pages/log_in/log_in_page.dart';
import 'package:stoady/pages/user/sign_up/sign_up_page.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;

  const AlreadyHaveAnAccountCheck({
    Key? key,
    this.login = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "Don’t have an Account? " : "Already have an Account? ",
          style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
              color: Colors.black38),
        ),
        GestureDetector(
          onTap: !login ? () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LogInPage())) :
              () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const SignUpPage())),
          child: Text(
            login ? "SIGN UP" : "SIGN IN",
            style: const TextStyle(
              decoration: TextDecoration.underline,
              color: Colors.teal,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
