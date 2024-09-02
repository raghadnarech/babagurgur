class Classroom {
  int? id;
  String? name;
  Classroom({this.id, this.name});

  factory Classroom.fromJson(dynamic responsedata) {
    return Classroom(
      id: responsedata['id'],
      name: responsedata['name'],
    );
  }
}
