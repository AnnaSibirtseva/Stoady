import 'package:flutter/material.dart';
import 'package:stoady/models/group.dart';
import 'package:stoady/models/subject.dart';

class GroupCard extends StatelessWidget {
  const GroupCard({
    Key? key,
    required this.group,
    required this.press,
  }) : super(key: key);

  final Group group;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: press,
        child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 20, vertical: 30),
            child: Row(
                children: [
                  Stack(
                    children: [
                      ClipOval(
                        child: Image.network(
                          group.getAvatar(),
                          width: 95,
                          height: 95,
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  ),
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(group.getGroupName(),
                                  style: const TextStyle(
                                      fontSize: 24,
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