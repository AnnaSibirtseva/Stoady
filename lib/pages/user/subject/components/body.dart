import 'package:flutter/material.dart';
import 'package:stoady/models/logic.dart';
import 'package:stoady/models/subject.dart';
import 'package:stoady/pages/user/subject/components/topic_card.dart';
import 'package:stoady/pages/user/topics/topic_page.dart';

import 'background.dart';

class Body extends StatelessWidget {
  final Subject currentSubject;

  const Body({Key? key, required this.currentSubject}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      currentSubject: currentSubject,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.16),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                child: Text(currentSubject.getDescription(),
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Montserrat",
                        color: Colors.black45))),
            Expanded(
                child: ListView.builder(
                    itemCount: Logic.allTopics.length,
                    itemBuilder: (context, index) =>
                    TopicCard(
                        topic: Logic.allTopics[index],
                        press: () =>  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TopicPage(currentTopic:Logic.allTopics[index]))),
                    ),
                    )),
          ]),
    );
  }
}
