import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stoady/models/logic.dart';

import 'package:http/http.dart' as http;

class SavedStar extends StatelessWidget {
  const SavedStar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (Logic.currentUser.isSaved(Logic.questions[Logic.currentIndex])) {
      return GestureDetector(
          onTap: () => {
                (context as Element).reassemble(),
                removeQuestion(Logic.questions[Logic.currentIndex].id, context),
                build(context)
              },
          child: Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              "assets/images/saved_empty.png",
              width: size.width * 0.09,
            ),
          ));
    }
    return GestureDetector(
        onTap: () => {
              (context as Element).reassemble(),
              addQuestion(Logic.questions[Logic.currentIndex].id, context),
              build(context)
            },
        child: Positioned(
          top: 0,
          right: 0,
          child: Image.asset(
            "assets/images/saved_filled.png",
            width: size.width * 0.09,
          ),
        ));
  }
}

Future<void> addQuestion(int questionId, BuildContext context) async {
  var client = http.Client();
  try {
    var response = await http.put(
        Uri.https('stoady.herokuapp.com', '/questions/save/$questionId'),
        headers: {'userId': Logic.currentUser.id.toString()});
    if (response.statusCode == 200) {
      Logic.currentUser.saved.add(
          Logic.questions.where((element) => element.id == questionId).first);
      (context as Element).reassemble();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Something went wrong, question wasn't added.")));
    }
  } finally {
    client.close();
  }
}

Future<void> removeQuestion(int questionId, BuildContext context) async {
  var client = http.Client();
  try {
    var response = await http.delete(
        Uri.https('stoady.herokuapp.com', '/questions/unsave/$questionId'),
        headers: {'userId': Logic.currentUser.id.toString()});
    Logic.currentUser.saved.remove(
        Logic.questions.where((element) => element.id == questionId).first);
    (context as Element).reassemble();
    if (response.statusCode != 200) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Something went wrong, question wasn't removed.")));
    }
  } finally {
    client.close();
  }
}
