class Teacher {
  int? id;
  String? name;
  String? phone;

  Teacher({this.id, this.name, this.phone});
  factory Teacher.fromJson(dynamic responsedata) {
    return Teacher(
      id: responsedata['id'],
      name: responsedata['name'],
      phone: responsedata['phone'],
    );
  }
}
