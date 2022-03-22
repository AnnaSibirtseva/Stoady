import 'package:flutter/material.dart';
import 'package:stoady/models/topic.dart';
import 'package:stoady/models/topic_info.dart';

class Background extends StatelessWidget {
  final Widget child;
  final TopicInfo currentTopic;

  const Background({
    Key? key,
    required this.child,
    required this.currentTopic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: size.width,
      // Here i can use size.width but use double.infinity because both work as a same
      child: Stack(
          //alignment: Alignment.center,
          children: <Widget>[
            Row(children: <Widget>[
              SizedBox(height: size.height * 0.25, width: size.width * 0.06),
              Positioned(
                  child: Image.asset(
                "assets/images/topic_lily.png",
                width: size.width * 0.17,
              )),
              SizedBox(width: size.width * 0.03),
              Flexible(
                child: Text(currentTopic.name,
                    style: const TextStyle(
                        fontSize: 35.0,
                        fontWeight: FontWeight.w800,
                        color: Colors.black)),
              ),
            ]),
            SizedBox(height: size.height * 0.95),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 135),
                child: Flexible(
                    child: Text(currentTopic.description,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.black45)))),
            child,
          ]),
    );
  }
}
