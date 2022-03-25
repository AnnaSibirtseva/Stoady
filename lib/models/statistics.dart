import 'package:stoady/models/result.dart';

class Statistics {
  late List<Result> results = [];

  Statistics(this.results);

  factory Statistics.fromJson(dynamic json) {
    return Statistics(
        (json['results'] as List).map((e) => Result.fromJson(e)).toList());
  }
}
