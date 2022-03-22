import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:stoady/models/logic.dart';
import 'package:stoady/pages/user/home/home_page.dart';

import 'group_card.dart';

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
              SizedBox(height: size.height * 0.4, width: size.width * 0.02),
              Positioned(
                  child: Image.asset(
                "assets/images/business_frog.png",
                width: size.width * 0.16,
              )),
              const Text("Groups",
                  style:
                      TextStyle(fontSize: 35.0, fontWeight: FontWeight.w900)),
              Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(math.pi),
                child: Image.asset(
                  "assets/images/business_frog.png",
                  width: size.width * 0.16,
                ),
              ),
              SizedBox(height: size.height * 0.3, width: size.width * 0.02),
            ],
          ),
          Column(children: <Widget>[
            SizedBox(height: size.height * 0.25),
            Expanded(
                child: ListView.builder(
                    itemCount: Logic.userGroups.length,
                    itemBuilder: (context, index) => GroupCard(
                        avatar: Logic.userGroups[index].teamAvatar,
                        name: Logic.userGroups[index].teamName,
                        press: () => {
                              Logic.currentGroupId =
                                  Logic.userGroups[index].teamId,
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const UserHomePage())),
                            }))),
            SizedBox(height: size.height * 0.15),
          ]),
          child
        ]));
  }
}
