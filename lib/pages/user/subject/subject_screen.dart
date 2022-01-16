import 'package:flutter/material.dart';
import 'package:stoady/components/widgets/side_menu.dart';
import 'package:stoady/models/subject.dart';

import 'components/body.dart';

class SubjectPage extends StatefulWidget {
  final Subject currentSubject;

  const SubjectPage({Key? key, required this.currentSubject}) : super(key: key);

  @override
  State<SubjectPage> createState() => _SubjectPage(currentSubject);
}

class _SubjectPage extends State<SubjectPage> {
  final Subject currentSubject;

  _SubjectPage(this.currentSubject);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        drawer: const SideMenu(),
        body: Center(child: Body(currentSubject: currentSubject))
    );
  }
}
