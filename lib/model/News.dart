class News {
  int? id;
  int? roomid;
  String? text;

  News({this.id, this.roomid, this.text});

  factory News.fromJson(dynamic responsedata) {
    return News(
        id: responsedata['id'],
        roomid: responsedata['room_id'],
        text: responsedata['text']);
  }
}
