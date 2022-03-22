import 'package:flutter/material.dart';
import 'package:stoady/models/logic.dart';
import 'package:stoady/pages/user/home/components/subject_card.dart';
import 'package:stoady/pages/user/subject/subject_screen.dart';

import 'background.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  Widget _page(int index) {
    Logic.currentSubjectId = Logic.allSubjects[index].id;
    Logic.currentSubject = Logic.allSubjects[index];
    return SubjectPage();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Background(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
        SizedBox(height: size.height * 0.16),
        Expanded(
            child: ListView.builder(
              itemCount: Logic.allSubjects.length,
              itemBuilder: (context, index) =>
                  SubjectCard(
                    subject: Logic.allSubjects[index],
                    press: () =>
                    {
                      Logic.currentSubjectId = Logic.allSubjects[index].id,
                      Logic.currentSubject = Logic.allSubjects[index],
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SubjectPage()))},
                  ),
            )
        )]
    )
    ,
    );
  }
}


