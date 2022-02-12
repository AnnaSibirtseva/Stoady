import 'package:flutter/material.dart';
import 'package:stoady/components/widgets/side_menu.dart';
import 'package:stoady/pages/user/group/components/body.dart';

class GroupPage extends StatefulWidget {
  const GroupPage({Key? key}) : super(key: key);

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        drawer: const SideMenu(),
        body: const Center(
            child: SingleChildScrollView(reverse: true, child: Body())));
  }
}
