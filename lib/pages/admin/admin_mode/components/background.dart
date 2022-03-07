import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:stoady/models/logic.dart';

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
        child: Stack(
            children: <Widget>[
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
                          fontSize: 32.0,
                          fontWeight: FontWeight.w900)),
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
              child
            ]
        )
    );
  }
}
