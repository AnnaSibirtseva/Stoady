import 'package:flutter/material.dart';
import 'package:stoady/models/logic.dart';
import 'package:stoady/pages/user/statistics/components/score_card.dart';

import 'background.dart';

class Body extends StatelessWidget {

  const Body({Key? key}) : super(key: key);

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
                  itemCount: Logic.currentUser.statistics.length,
                  itemBuilder: (context, index) =>
                      ScoreCard(
                        statistics: Logic.currentUser.statistics[index]
                      ),
                )),
          ]),
    );
  }
}
