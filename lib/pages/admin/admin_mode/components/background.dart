import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:stoady/models/logic.dart';
import 'package:stoady/models/member.dart';
import 'package:stoady/models/user.dart';
import 'package:stoady/pages/admin/admin_mode/components/person_card.dart';

import '../filter.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // This size provide us total height and width of our screen
    Size size = MediaQuery.of(context).size;
    return SizedBox(
        height: size.height,
        width: double.infinity,
        child: Stack(children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(width: size.width * 0.02),
              Positioned(
                  child: Image.asset(
                "assets/images/cattail.png",
                width: size.width * 0.13,
              )),
              Text(Logic.currentGroup.getName(),
                  style: const TextStyle(
                      fontSize: 32.0, fontWeight: FontWeight.w900)),
              Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(math.pi),
                child: Image.asset(
                  "assets/images/cattail.png",
                  width: size.width * 0.13,
                ),
              ),
              SizedBox(height: size.height * 0.15, width: size.width * 0.02),
            ],
          ),
          Column(children: <Widget>[
            SizedBox(height: size.height * 0.27, width: size.width * 0.44),
            const Text("Members:",
                //textAlign: TextAlign.left,
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w900)),
          ]),
          Column(
            children: [
              SizedBox(height: size.height * 0.4),
              Expanded(
                  child: ListView.builder(
                      itemCount: Logic.members.members.length,
                      itemBuilder: (context, index) =>
                          buildItem(context, index))),
              SizedBox(height: size.height * 0.2),
            ],
          ),
          child,
        ]));
  }

  Widget buildItem(BuildContext context, int index) {
    Member curUser = Logic.members.members.elementAt(index);
    if (Filter.getBool("admin")) {
      if (Logic.members.members.where((element) => element.id == curUser.id).first.isAdmin()) {
        return PersonCard(user: curUser);
      }
    }
    if (Filter.getBool("student")) {
      if (!(Logic.members.members.where((element) => element.id == curUser.id).first.isAdmin())) {
        return PersonCard(user: curUser);
      }
    }
    // Костыль, потому что надо возвращать виджет.
    return const Visibility(
      child: Text("Invisible", style: TextStyle(fontSize: 0)),
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      visible: false,
    );
  }
}
