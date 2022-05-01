import 'package:flutter/material.dart';
import 'package:stoady/models/logic.dart';

import 'package:http/http.dart' as http;

class AvatarRow extends StatelessWidget {
  const AvatarRow({
    Key? key,
    required this.photos,
  }) : super(key: key);

  final List<String> photos;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(children: [
          buildRow(0, size, context),
          buildRow(3, size, context),
          buildRow(6, size, context),
          buildRow(9, size, context),
          buildRow(12, size, context),
        ]));
  }

  Widget createAvatar(int index, BuildContext context) {
    return GestureDetector(
        child: Opacity(
            opacity: photos[index] == Logic.currentUser.getAvatar() ? 1 : 0.4,
            child: Image.network(
              photos[index],
              width: 90,
              height: 90,
              fit: BoxFit.cover,
            )),
        onTap: () => {
              Logic.currentUser.avatarId = index,
              changeAvatar(index),
              (context as Element).reassemble(),
            });
  }

  Widget buildRow(int index, Size size, BuildContext context) {
    return Column(children: <Widget>[
      Row(children: <Widget>[
        createAvatar(index, context),
        SizedBox(width: size.width * 0.1),
        createAvatar(index + 1, context),
        SizedBox(width: size.width * 0.1),
        createAvatar(index + 2, context),
      ]),
      SizedBox(height: size.height * 0.025, width: size.width * 0.1),
    ]);
  }

  Future<void> changeAvatar(int newIndex) async {
    var client = http.Client();
    try {
      var response = await client.put(Uri.https(
          'stoady.herokuapp.com',
          '/users/${Logic.currentUser.id}/avatar/set',
          {'avatarId': newIndex.toString()}));
      if (response.statusCode != 200) {
        // todo handle exception
        throw Exception();
      }
    } finally {
      client.close();
    }
  }
}
