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
    return SizedBox(
        height: size.height,
        width: double.infinity,
        child: Stack(children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(height: size.height * 0.2, width: size.width * 0.13),
              Positioned(
                  child: Image.asset(
                    "assets/images/frog_prince.png",
                    width: size.width * 0.15,
                  )),
              SizedBox(width: size.width * 0.025),
              const Text("Statistics",
                  style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.black)),
              SizedBox(width: size.width * 0.025),
              Positioned(
                  child: Image.asset(
                    "assets/images/frog_prince.png",
                    width: size.width * 0.15,
                  )),
            ],
          ),
          child,
        ]));
  }
}
