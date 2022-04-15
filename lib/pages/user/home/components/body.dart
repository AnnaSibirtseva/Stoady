import 'package:flutter/material.dart';
import 'package:stoady/models/logic.dart';
import 'package:stoady/pages/admin/subject_manager/subject_manager_page.dart';
import 'package:stoady/pages/user/home/components/subject_card.dart';
import 'package:stoady/pages/user/subject/subject_screen.dart';

import 'background.dart';

class Body extends StatelessWidget {
  final bool showAddButton;

  const Body({Key? key, required this.showAddButton}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.16),
            Expanded(
                child: ListView.builder(
              itemCount: Logic.allSubjects.length,
              itemBuilder: (context, index) => SubjectCard(
                subject: Logic.allSubjects[index],
                press: () => {
                  Logic.currentSubjectId = Logic.allSubjects[index].id,
                  Logic.currentSubject = Logic.allSubjects[index],
                  if (!showAddButton)
                    {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SubjectPage()))
                    }
                  else
                    {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const SubjectManagerPage(isNew: false)))
                    }
                },
              ),
            )),
            Visibility(
              child: FloatingActionButton(
                onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const SubjectManagerPage(isNew: true))),
                child: const Icon(Icons.add_rounded, size: 35),
              ),
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              visible: showAddButton,
            ),
            SizedBox(height: size.height * 0.012),
          ]),
    );
  }
}
