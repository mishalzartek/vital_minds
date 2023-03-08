// To parse this JSON data, do
//
//     final users = usersFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

User usersFromMap(String str) => User.fromMap(json.decode(str));

String usersToMap(User data) => json.encode(data.toMap());

class User {
  User({@required this.age, this.email, this.phno});

  String age;
  String email;
  String phno;

  factory User.fromMap(Map<String, dynamic> json) =>
      User(age: json["age"], email: json["email"],phno:json["phone"]);

  Map<String, dynamic> toMap() => {"age": age, "email": email,"phone":phno};
}
