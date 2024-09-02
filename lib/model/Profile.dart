class Profile {
  int? id;
  String? name;
  String? phone;

  Profile({this.id, this.name, this.phone});

  factory Profile.fromJson(dynamic responsedata) {
    return Profile(
      id: responsedata['id'],
      name: responsedata['name'],
      phone: responsedata['phone'],
    );
  }
}
