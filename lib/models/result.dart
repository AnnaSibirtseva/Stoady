class Result {
  late int topicId;
  late String name;
  late int result;

  Result(this.topicId, this.name, this.result);

  factory Result.fromJson(dynamic json) {
    return Result(json['topicId'] as int, json['topicName'] as String,
        json['result'] as int);
  }
}
