import 'package:flutter/material.dart';
import 'package:stoady/models/subject.dart';

class Background extends StatelessWidget {
  final Widget child;
  final Subject currentSubject;

  const Background({
    Key? key,
    required this.child,
    required this.currentSubject,
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
            Row(children: <Widget>[
              SizedBox(height: size.height * 0.2),
              SizedBox(width: size.height * 0.04),
              Positioned(
                  child: Image.asset(
                "assets/images/subject_lily.png",
                width: size.width * 0.15,
              )),
              SizedBox(width: size.height * 0.025),
              Flexible(
                child: Text(currentSubject.getTitle(),
                    style: const TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.w800,
                        color: Colors.black)),
              )
            ]),
            child,
          ]),
    );
  }
}
