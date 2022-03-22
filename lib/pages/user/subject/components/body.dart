import 'package:flutter/material.dart';
import 'package:stoady/models/logic.dart';
import 'package:stoady/models/subject.dart';
import 'package:stoady/pages/user/subject/components/topic_card.dart';
import 'package:stoady/pages/user/topics/topic_page.dart';

import 'background.dart';

class Body extends StatelessWidget {
  const Body({Key? key, required this.subject}) : super(key: key);

  final Subject subject;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      currentSubject: subject,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.16),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                child: Text(subject.getDescription(),
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black45))),
            Expanded(
                child: ListView.builder(
              itemCount: subject.topics.length,
              itemBuilder: (context, index) => TopicCard(
                topic: subject.topics[index],
                press: () => {
                  Logic.currentTopicId = subject.topics[index].id,
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const TopicPage()))
                },
              ),
            )),
          ]),
    );
  }
}
