import 'package:flutter/material.dart';
import 'package:stoady/components/widgets/side_menu.dart';
import 'package:stoady/pages/user/learn/components/background.dart';

class LearningPage extends StatefulWidget {
  const LearningPage({
    Key? key,
  }) : super(key: key);

  @override
  State<LearningPage> createState() => _LearningPage();
}

class _LearningPage extends State<LearningPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        drawer: const SideMenu(),
        body: Center(
          child: Background(
              child: Container()),
        ));
  }
}
