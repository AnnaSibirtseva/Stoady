import 'package:flutter/material.dart';
import 'package:stoady/models/topic_info.dart';

class TopicCard extends StatelessWidget {
  const TopicCard({
    Key? key,
    required this.topic,
    required this.press,
  }) : super(key: key);

  final TopicInfo topic;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
        onTap: press,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(children: [
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 7),
                      child: Text(
                        topic.name,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w700),
                      ))),
              Expanded(
                  child: Align(
                      alignment: Alignment.topRight,
                      child: Image.asset('assets/images/right_arrow.png',
                          width: size.width * 0.1)))
            ])));
  }
}
