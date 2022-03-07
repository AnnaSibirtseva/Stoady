import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stoady/components/text_boxes/rounded_input.dart';
import 'package:stoady/pages/admin/admin_mode/filter.dart';

import 'background.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
        child: Center(
            child: Column(children: <Widget>[
      SizedBox(height: size.height * 0.15),
      Row(
        children: [
          SizedBox(width: size.width * 0.1),
          Align(
              alignment: FractionalOffset.bottomLeft,
              child: RoundedInputField(
                hintText: "Add Student",
                onChanged: (value) {},
                icon: Icons.groups_rounded,
                isSmall: true,
                isAnswer: false,
              )),
          SizedBox(width: size.width * 0.05),
          FloatingActionButton(
            //Todo: add student (but how? it's another layer)
            onPressed: () => {},
            child: const Icon(Icons.add_rounded, size: 35),
          ),
          SizedBox(width: size.width * 0.05),
        ],
      ),
      Column(
        children: <Widget>[
          SizedBox(height: size.height * 0.07),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              drawFilterChip("admin", context),
              drawFilterChip("student", context),
            ],
          ),
        ],
      )
    ])));
  }
}

Widget drawFilterChip(String query, BuildContext context) {
  return FilterChip(
      showCheckmark: false,
      selected: Filter.getBool(query),
      avatar: Filter.getBool(query)
          ? const Icon(Icons.check, color: Colors.green)
          : const Icon(Icons.add, color: Colors.blueGrey),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide(
          color: Filter.getBool(query) ? Colors.green : Colors.blueGrey,
        ),
      ),
      backgroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(
      horizontal: 30, vertical: 6),
      label: Text(
        Filter.getString(query),
        style: TextStyle(
          fontSize: 16.0,
          height: 1.4,
          fontWeight: FontWeight.normal,
          color: Filter.getBool(query) ? Colors.green : Colors.blueGrey,
        ),
      ),
      selectedColor: Colors.white,
      onSelected: (bool selected) {
        Filter.changeBool(query);
        (context as Element).reassemble();
      });
}
