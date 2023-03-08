// To parse this JSON data, do
//
//     final habitsModel = habitsModelFromMap(jsonString);

import 'dart:convert';

HabitsModel habitsModelFromMap(String str) =>
    HabitsModel.fromMap(json.decode(str));

String habitsModelToMap(HabitsModel data) => json.encode(data.toMap());

class HabitsModel {
  HabitsModel({
    this.habits,
  });

  List<Habit> habits = [];

  factory HabitsModel.fromMap(Map<String, dynamic> json) {
    try {
      List<Habit> habits =
          List<Habit>.from(json["habits"].map((x) => Habit.fromMap(x)));
      return HabitsModel(
        habits: habits,
      );
    } catch (e) {
      return HabitsModel(
        habits: [],
      );
    }
  }

  Map<String, dynamic> toMap() => {
        "habits": List<dynamic>.from(habits.map((x) => x.toMap())),
      };
}

class Habit {
  String title;
  List<bool> days = [];
  bool status;
  Habit({
    this.title,
    this.days,
    this.status,
  });

  factory Habit.fromMap(Map<String, dynamic> json) {
    try {
      List<bool> days = List<bool>.from(json["days"]);
      return Habit(
        title: json['title'],
        status: json['status'],
        days: days,
      );
    } catch (e) {
      return Habit(
        title: json['title'],
        status: json['status'],
        days: [],
      );
    }
  }

  Map<String, dynamic> toMap() => {
        "title": title,
        "days": List<dynamic>.from(days),
        "status": status,
      };
}
