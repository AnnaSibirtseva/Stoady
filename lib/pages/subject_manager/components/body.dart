import 'package:flutter/material.dart';
import 'package:stoady/models/logic.dart';
import 'package:stoady/pages/subject_manager/components/topic_card.dart';

import 'background.dart';

class Body extends StatelessWidget {
  final bool isNew;

  const Body({Key? key, required this.isNew}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      isNew: isNew,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //SizedBox(height: size.height * 0.16),
            SizedBox(
                height: 200.0,
                child: Expanded(
                    child: ListView.builder(
                  //shrinkWrap: true,
                  itemCount: isNew ? 0 :Logic.currentSubject.topics.length,
                  itemBuilder: (context, index) => TopicCard(
                    topic: Logic.currentSubject.topics[index],
                    press: () => {},
                  ),
                ))),
          ]),
    );
  }
}
