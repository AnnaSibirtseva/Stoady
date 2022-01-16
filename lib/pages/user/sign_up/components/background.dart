import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget body;

  const Background({
    Key? key,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      // Here i can use size.width but use double.infinity because both work as a same
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              "assets/images/slime.png",
              width: size.width * 1,
            ),
          ),
          body,
        ],
      ),
    );
  }
}
