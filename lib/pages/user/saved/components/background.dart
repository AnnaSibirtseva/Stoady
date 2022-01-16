import 'package:flutter/material.dart';
import 'package:stoady/models/topic.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      // Here i can use size.width but use double.infinity because both work as a same
      child: Stack(
          //alignment: Alignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(height: size.height * 0.12, width: size.height * 0.60),
                const Flexible(
                  child: Text("Saved Questions",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 35.0,
                          fontWeight: FontWeight.w800,
                          fontFamily: "Montserrat",
                          color: Colors.black)),
                ),
                SizedBox(height: size.height * 0.025),
                Positioned(
                    child: Image.asset(
                      "assets/images/toad.png",
                      width: size.width * 0.85,
                    )),
                SizedBox(height: size.height * 0.05),
              ],
            ),
            child,
          ]),
    );
  }
}
