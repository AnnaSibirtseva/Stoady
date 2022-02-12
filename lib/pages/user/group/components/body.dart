import 'package:flutter/material.dart';
import 'package:stoady/components/text_boxes/rounded_input.dart';

import 'background.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
        child: Center(
            child: Column(children: <Widget>[
      SizedBox(height: size.height * 0.87),
      Row(
        children: [
          SizedBox(width: size.width * 0.09),
          Align(
              alignment: FractionalOffset.bottomLeft,
              child: RoundedInputField(
                hintText: "Group Name",
                onChanged: (value) {},
                icon: Icons.groups_rounded,
                isSmall: true,
                isAnswer: false,
              )),
          SizedBox(width: size.width * 0.05),
          FloatingActionButton(
            //Todo: create group (but how? it's another layer)
            onPressed: () => {},
            child: const Icon(Icons.add_rounded, size: 35),
          )
        ],
      )
    ])));
  }
}
