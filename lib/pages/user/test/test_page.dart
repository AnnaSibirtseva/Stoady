import 'package:flutter/material.dart';
import 'package:stoady/components/widgets/side_menu.dart';

import 'components/background.dart';

class TestingPage extends StatefulWidget {
  const TestingPage({
    Key? key,
  }) : super(key: key);

  @override
  State<TestingPage> createState() => _TestingPage();
}

class _TestingPage extends State<TestingPage> {

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
