class User {
  int? id;
  String? name;
  String? token;
  String? phone;
  String? role;

  User({this.token, this.role, this.id, this.phone, this.name});

  factory User.fromJson(Map<String, dynamic> responsedata) {
    return User(
      id: responsedata['user']['id'] ?? "",
      name: responsedata['user']['name'] ?? "",
      phone: responsedata['user']['phone'] ?? "",
      role: responsedata['role'] ?? "",
      token: responsedata['token'],
    );
  }
}
