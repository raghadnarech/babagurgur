class Room {
  int? id;
  int? classid;
  String? name;
  Room({this.classid, this.id, this.name});

  factory Room.fromJson(dynamic responsedata) {
    return Room(
      id: responsedata['id'],
      classid: responsedata['clas_id'],
      name: responsedata['name'],
    );
  }
}
