
class Subject {
  late int id;
  late final String name;
  late final String description;

  Subject(this.id,
          this.name,
          this.description);

  factory Subject.fromJson(dynamic json) {
    return Subject(json['id'] as int, json['name'] as String,
        json['description'] as String);
  }

  String getTitle() {
    return name;
  }

  int getID() {
    return id;
  }

  String getDescription() {
    return description;
  }
}
