import 'package:flutter/material.dart';
import 'package:stoady/models/group.dart';

class PersonCard extends StatelessWidget {
  const PersonCard({
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
                horizontal: 20, vertical: 15),
            child: Row(
                children: [
                  Stack(
                    children: [
                      ClipOval(
                        child: Image.network(
                          group.getAvatar(),
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
                                Text(group.getGroupName(),
                                  style: const TextStyle(
                                      fontSize: 20,
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