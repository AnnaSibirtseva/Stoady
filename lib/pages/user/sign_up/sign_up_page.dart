import 'package:flutter/material.dart';
import 'package:stoady/pages/user/sign_up/components/body.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPage();
}

class _SignUpPage extends State<SignUpPage> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Body());
  }
}
