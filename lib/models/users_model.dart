class UsersModel {
  UsersModel({
    this.data,
  });

  Data data;

  factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
        data: Data.fromJson(json["users"]),
      );
}

class Data {
  Data({
    this.users,
  });

  List<User> users;

  factory Data.fromJson(List<dynamic> json) =>
      Data(users: json.map((e) => User.fromJson(e)).toList());
}

class User {
  User({
    this.id,
    this.name,
    this.rocket,
    this.twitter,
  });

  String id;
  String name;
  String rocket;
  String twitter;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        rocket: json["rocket"] == null ? null : json["rocket"],
        twitter: json["twitter"] == null ? null : json["twitter"],
      );
}
