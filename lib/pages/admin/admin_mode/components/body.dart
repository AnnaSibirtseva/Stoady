import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stoady/components/text_boxes/rounded_input.dart';
import 'package:stoady/components/widgets/buttons/rounded_button.dart';
import 'package:stoady/models/logic.dart';
import 'package:http/http.dart' as http;
import 'package:stoady/pages/admin/admin_mode/admin_mode_page.dart';
import 'package:stoady/pages/admin/admin_mode/filter.dart';
import 'package:stoady/pages/user/home/home_page.dart';

import 'background.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String userMail = "";
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
                onChanged: (value) {
                  userMail = value;
                },
                icon: Icons.groups_rounded,
                isSmall: true,
                isAnswer: false,
              )),
          SizedBox(width: size.width * 0.05),
          FloatingActionButton(
            onPressed: () async {
              var client = http.Client();
              try {
                var response = await http.post(
                    Uri.https(
                        'stoady.herokuapp.com',
                        '/teams/${Logic.currentGroupId}/members/add',
                        {'email': userMail}),
                    headers: {'executorId': Logic.currentUser.id.toString()});
                if (response.statusCode == 200) {
                  // Rebuilding page with groups.
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const AdminModePage()));
                } else {
                  // Notifying user that sth went wrong.
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                          "Add Failed. Check that the mail is entered correctly.")));
                }
              } finally {
                client.close();
              }
            },
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
      ),
      SizedBox(height: size.height * 0.42),
      ElevatedButton(
        child: const Text(
          "Manage Subjects",
          style: TextStyle(
              fontSize: 24.0,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w700,
              color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            primary: Colors.teal,
            // Moves text in the button.
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 7)),
        onPressed: () =>
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                  const UserHomePage(showAddButton: true))),
      )
    ])));
  }
}

Widget drawFilterChip(String query, BuildContext context) {
  return FilterChip(
      showCheckmark: false,
      selected: Filter.getBool(query),
      avatar: Filter.getBool(query)
          ? const Icon(Icons.check_circle_outline_rounded, color: Colors.green)
          : const Icon(Icons.circle_outlined, color: Colors.blueGrey),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide(
          color: Filter.getBool(query) ? Colors.green : Colors.blueGrey,
        ),
      ),
      backgroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 6),
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
