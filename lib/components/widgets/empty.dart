import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stoady/components/widgets/side_menu.dart';

class NothingFoundWidget extends StatelessWidget {
  final String text;

  const NothingFoundWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        drawer: const SideMenu(),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              Image.asset(
                "assets/images/empty.png",
                height: 125.0,
                width: 125.0,
              ),
              const SizedBox(height: 30),
              Text(text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 32.0, fontWeight: FontWeight.w900)),
            ])));
  }
}
