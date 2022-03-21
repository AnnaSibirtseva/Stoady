import 'package:flutter/material.dart';
import 'package:stoady/models/group.dart';
import 'package:stoady/models/subject.dart';

class GroupCard extends StatelessWidget {
  const GroupCard({
    Key? key,
    required this.avatar,
    required this.name,
    required this.press,
  }) : super(key: key);

  final String avatar;
  final String name;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: press,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(children: [
              Stack(
                children: [
                  ClipOval(
                    child: Image.network(
                      avatar,
                      width: 85,
                      height: 85,
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800),
                            ),
                            const SizedBox(height: 3),
                          ])))
            ])));
  }
}
