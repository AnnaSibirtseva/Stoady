import 'package:flutter/material.dart';
import 'package:stoady/components/widgets/side_menu.dart';
import 'package:stoady/pages/user/saved/components/body.dart';

class SavedQuestionsPage extends StatefulWidget {
  const SavedQuestionsPage({Key? key}) : super(key: key);

  @override
  State<SavedQuestionsPage> createState() => _SavedQuestionsPage();
}

class _SavedQuestionsPage extends State<SavedQuestionsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        drawer: const SideMenu(),
        body: const Center(child: Body())
    );
  }
}