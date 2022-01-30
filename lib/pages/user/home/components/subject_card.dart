import 'package:flutter/material.dart';
import 'package:stoady/models/subject.dart';

class SubjectCard extends StatelessWidget {
  const SubjectCard({
    Key? key,
    required this.subject,
    required this.press,
  }) : super(key: key);

  final Subject subject;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 20, vertical: 20),
        child: Row(
          children: [
            Stack(
              children: const [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage("assets/images/subject_lily.png"),
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
                      subject.getTitle(),
                      style: const TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.w800
                      ),
                    ),
                    const SizedBox(height: 3),
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