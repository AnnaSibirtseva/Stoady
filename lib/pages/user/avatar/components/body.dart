import 'package:flutter/material.dart';
import 'package:stoady/models/random.dart';
import 'package:stoady/pages/user/avatar/components/avatar_row.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        reverse: true,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.01),
              const Text("Select Avatar",
                  style:
                      TextStyle(fontSize: 35.0, fontWeight: FontWeight.w900)),
              //SizedBox(height: size.height * 0.53),
              AvatarRow(photos: RandomFrog.getPhotos())
            ]));
  }
}
