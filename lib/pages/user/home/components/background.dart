import 'package:flutter/material.dart';

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
    return Container(
        height: size.height,
        width: double.infinity,
        child: Stack(children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(height: size.height * 0.2),
              SizedBox(width: size.height * 0.05),
              Positioned(
                  child: Image.asset(
                "assets/images/first_frog.png",
                width: size.width * 0.15,
              )),
              const Text("All Subjects",
                  style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.w900,
                      fontFamily: "Montserrat",
                      color: Colors.teal)),
              Positioned(
                  child: Image.asset(
                "assets/images/second_frog.png",
                width: size.width * 0.15,
              )),
            ],
          ),
          child,
        ]));
  }
}
