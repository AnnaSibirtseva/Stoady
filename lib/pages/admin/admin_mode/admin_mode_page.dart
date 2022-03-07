import 'package:flutter/material.dart';
import 'package:stoady/components/widgets/side_menu.dart';
import 'package:stoady/pages/admin/admin_mode/components/body.dart';

class AdminModePage extends StatefulWidget {
  const AdminModePage({Key? key}) : super(key: key);

  @override
  State<AdminModePage> createState() => _AdminModePage();
}

class _AdminModePage extends State<AdminModePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        drawer: const SideMenu(),
        body: const Center(
            child: SingleChildScrollView(reverse: false, child: Body())));
  }
}
