import 'package:flutter/material.dart';
import 'package:stoady/components/widgets/side_menu.dart';
import 'package:stoady/pages/user/avatar/components/body.dart';

class SelectAvatarPage extends StatefulWidget {
  const SelectAvatarPage({Key? key}) : super(key: key);

  @override
  State<SelectAvatarPage> createState() => _SelectAvatarPageState();
}

class _SelectAvatarPageState extends State<SelectAvatarPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        drawer: const SideMenu(),
        body: const Center(child: Body())
    );
  }
}