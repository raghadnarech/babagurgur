class Schedule {
  int? id;
  int? roomid;
  String? image;

  Schedule({this.id, this.image, this.roomid});

  factory Schedule.fromJson(dynamic responsedate) {
    return Schedule(
      id: responsedate['id'],
      image: responsedate['image'],
      roomid: responsedate['room_id'],
    );
  }
}
