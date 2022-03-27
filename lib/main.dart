import 'package:flutter/material.dart';
import 'package:stoady/pages/log_in/log_in_page.dart';
import 'package:stoady/pages/user/group/group_page.dart';
import 'package:stoady/pages/user/home/home_page.dart';

void main() {
  //todo придумать что-то с ориентацией (чтобы не менялась)
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Nunito',
        primarySwatch: Colors.teal,
      ),
      home: const LogInPage(),
    );
  }
}
