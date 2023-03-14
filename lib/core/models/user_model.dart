// To parse this JSON data, do
//
//     final users = usersFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UserModel usersFromMap(String str) => UserModel.fromMap(json.decode(str));

String usersToMap(UserModel data) => json.encode(data.toMap());

class UserModel {
  UserModel({@required this.age, this.email, this.phno});

  String age;
  String email;
  String phno;

  factory UserModel.fromMap(Map<String, dynamic> json) =>
      UserModel(age: json["age"], email: json["email"],phno:json["phone"]);

  Map<String, dynamic> toMap() => {"age": age, "email": email,"phone":phno};
}
