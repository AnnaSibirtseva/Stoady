/*ListTile(
            leading: const Icon(Icons.star_outline_rounded,
                size: 35, color: Colors.black),
            title: const Text('Saved',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Montserrat")),
            onTap: () => null,
          )*/
import 'package:flutter/material.dart';
import 'package:stoady/models/topic.dart';

class Background extends StatelessWidget {
  final Widget child;
  final Topic currentTopic;

  const Background({
    Key? key,
    required this.child,
    required this.currentTopic,
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
              SizedBox(height: size.height * 0.065, width: size.height * 0.017),
              GestureDetector(
                onTap: () => Navigator.pop(context), // Image tapped
                child: Image.asset('assets/images/back_button.png',
                    width: size.width * 0.2),
              )
            ]),
            Row(children: <Widget>[
              SizedBox(height: size.height * 0.25, width: size.height * 0.04),
              Positioned(
                  child: Image.asset(
                "assets/images/topic_lily.png",
                width: size.width * 0.17,
              )),
              SizedBox(width: size.height * 0.025),
              Flexible(
                child: Text(currentTopic.getTitle(),
                    style: const TextStyle(
                        fontSize: 35.0,
                        fontWeight: FontWeight.w800,
                        fontFamily: "Montserrat",
                        color: Colors.black)),
              ),
            ]),
            SizedBox(height: size.height * 0.95),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 135),
                child: Flexible(
                    child: Text(currentTopic.getDescription(),
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Montserrat",
                            color: Colors.black45)))),
            child,
          ]),
    );
  }
}
