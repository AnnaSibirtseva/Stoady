import 'package:flutter/material.dart';
import 'package:stoady/pages/log_in/components/body.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPage();
}

class _LogInPage extends State<LogInPage> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Body());
  }
}
