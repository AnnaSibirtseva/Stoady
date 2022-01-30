import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget body;

  const Background({
    Key? key,
    required this.body,
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
          Positioned(
              child: Image.asset(
            "assets/images/slime.png",
            width: size.width * 1,
          )),
          body,
        ],
      ),
    );
  }
}
