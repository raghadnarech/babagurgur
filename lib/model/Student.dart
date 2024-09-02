class Student {
  int? id;
  String? name;
  String? phone;

  Student({this.id, this.name, this.phone});
  factory Student.fromJson(dynamic responsedata) {
    return Student(
      id: responsedata['id'],
      name: responsedata['name'],
      phone: responsedata['phone'],
    );
  }
}
