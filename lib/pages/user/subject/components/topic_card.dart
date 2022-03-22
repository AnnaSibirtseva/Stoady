import 'package:flutter/material.dart';
import 'package:stoady/models/topic.dart';
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
    return InkWell(
        onTap: press,
        child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 25, vertical: 10),
            child: Row(
                children: [
                  Stack(
                    children: const [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage("assets/images/topic_lily.png"),
                      )
                    ],
                  ),
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  topic.name,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w800
                                  ),
                                ),
                              ]
                          )
                      )
                  )
                ]
            )
        )
    );
  }
}