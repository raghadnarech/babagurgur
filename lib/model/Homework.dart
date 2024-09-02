class Homework {
  int? id;
  dynamic roomid;
  String? text;
  String? image;

  Homework({this.id, this.image, this.roomid, this.text});

  factory Homework.fromJson(dynamic responsedata) {
    return Homework(
        id: responsedata['id'],
        image: responsedata['image'],
        roomid: responsedata['room_id'],
        text: responsedata['text']);
  }
}
