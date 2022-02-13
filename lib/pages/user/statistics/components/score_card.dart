import 'package:flutter/material.dart';
import 'package:stoady/models/statistics.dart';

class ScoreCard extends StatelessWidget {
  const ScoreCard({
    Key? key,
    required this.statistics,
  }) : super(key: key);

  final Statistics statistics;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(children: [
              Stack(
                children: const [
                  CircleAvatar(
                    radius: 21,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage("assets/images/crown.png"),
                  )
                ],
              ),
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      child: Text(
                        statistics.getTopic(),
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w700),
                      ))),
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      child: Text(
                        statistics.getLastScore().toString() + "%",
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w900),
                      )))
            ])));
  }
}
