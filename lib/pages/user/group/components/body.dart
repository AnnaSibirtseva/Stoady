import 'package:flutter/material.dart';
import 'package:stoady/models/logic.dart';
import 'package:stoady/pages/user/home/components/subject_card.dart';
import 'package:stoady/pages/user/home/home_page.dart';
import 'package:stoady/pages/user/subject/subject_screen.dart';

import '../group_page.dart';
import 'background.dart';
import 'group_card.dart';

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
                    itemCount: Logic.allGroups.length,
                    itemBuilder: (context, index) => GroupCard(
                      group: Logic.allGroups[index],
                      press: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UserHomePage())
                      ),
                    )
                )),
          ]),
    );
  }
}
