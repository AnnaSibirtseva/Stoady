import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stoady/components/widgets/no_internet.dart';
import 'package:stoady/components/widgets/side_menu.dart';
import 'package:stoady/models/logic.dart';
import 'package:stoady/models/result.dart';
import 'package:stoady/models/statistics.dart';

import 'components/body.dart';
import 'package:http/http.dart' as http;

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  State<StatisticsPage> createState() => _StatisticsPage();
}

class _StatisticsPage extends State<StatisticsPage> {
  late Future<List<Result>> _futureResults;

  @override
  void initState() {
    super.initState();
    _futureResults = getResult();
  }

  Future<List<Result>> getResult() async {
    var client = http.Client();
    try {
      var response = await client.get(Uri.https(
          'stoady.herokuapp.com', '/stats/${Logic.currentUser.getId()}'));
      if (response.statusCode == 200) {
        return Statistics.fromJson(jsonDecode(utf8.decode(response.bodyBytes)))
            .results;
      } else {
        // todo handle exception
        throw Exception();
      }
    } finally {
      client.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        drawer: const SideMenu(),
        body: FutureBuilder<List<Result>>(
            future: _futureResults,
            builder:
                (BuildContext context, AsyncSnapshot<List<Result>> snapshot) {
              if (snapshot.hasData) {
                Logic.statistics = snapshot.data!;
                return const Center(child: Body());
              } else if (snapshot.hasError) {
                return const NoInternetWidget();
              } else {
                // By default, show a loading spinner.
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }
}
