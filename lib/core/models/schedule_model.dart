// To parse this JSON data, do
//
//     final scheduleModel = scheduleModelFromMap(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

ScheduleModel scheduleModelFromMap(String str) =>
    ScheduleModel.fromMap(json.decode(str));

String scheduleModelToMap(ScheduleModel data) => json.encode(data.toMap());

class ScheduleModel {
  ScheduleModel({
    this.reminders,
    this.todo,
    this.timestamp
  });

  List<Reminder> reminders;
  List<Todo> todo;
  Timestamp timestamp;

  factory ScheduleModel.fromMap(Map<String, dynamic> json) => ScheduleModel(
        reminders: List<Reminder>.from(
            json["reminders"].map((x) => Reminder.fromMap(x))),
        todo: List<Todo>.from(json["todo"].map((x) => Todo.fromMap(x))),
        timestamp: json["timestamp"]
      );

  Map<String, dynamic> toMap() => {
        "reminders": List<dynamic>.from(reminders.map((x) => x.toMap())),
        "todo": List<dynamic>.from(todo.map((x) => x.toMap())),
        "timestamp":timestamp
      };
}

class Reminder {
  Reminder({
    this.title,
    this.time,
    this.status,
  });

  String title;
  String time;
  bool status;

  factory Reminder.fromMap(Map<String, dynamic> json) => Reminder(
        title: json["title"],
        time: json["time"],
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "time": time,
        "status": status,
      };
}

class Todo {
  Todo({
    this.title,
    this.status,
  });

  String title;
  bool status;

  factory Todo.fromMap(Map<String, dynamic> json) => Todo(
        title: json["title"],
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "status": status,
      };
}
