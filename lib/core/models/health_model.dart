// To parse this JSON data, do
//
//     final healthModel = healthModelFromMap(jsonString);

import 'dart:convert';

import 'package:vitalminds/core/models/habits_model.dart';

HealthModel healthModelFromMap(String str) =>
    HealthModel.fromMap(json.decode(str));

String healthModelToMap(HealthModel data) => json.encode(data.toMap());

class HealthModel {
  HealthModel({
    this.habits,
    this.nutrition,
    this.excercise,
    this.totalCalories,
  });

  List<Habit> habits = [];
  Nutrition nutrition;
  List<Excercise> excercise;
  double totalCalories;

  factory HealthModel.fromMap(Map<String, dynamic> json) => HealthModel(
        habits: List<Habit>.from(json["habits"].map((x) => Habit.fromMap(x))),
        nutrition: Nutrition.fromMap(json["nutrition"]),
        excercise: List<Excercise>.from(
            json["excercise"].map((x) => Excercise.fromMap(x))),
        totalCalories: json['totalCalories'],
      );

  Map<String, dynamic> toMap() => {
        "habits": List<dynamic>.from(habits.map((x) => x.toMap())),
        "nutrition": nutrition.toMap(),
        "excercise": List<dynamic>.from(excercise.map((x) => x.toMap())),
        "totalCalories": totalCalories,
      };
}

class Excercise {
  Excercise({
    this.time,
    this.name,
    this.calories,
  });

  String time;
  String name;
  String calories;

  factory Excercise.fromMap(Map<String, dynamic> json) => Excercise(
        time: json["time"],
        name: json["name"],
        calories: json["calories"],
      );

  Map<String, dynamic> toMap() => {
        "time": time,
        "name": name,
        "calories": calories,
      };
}

// class Habit {
//   Habit({
//     this.title,
//     this.status,
//   });

//   String title;
//   bool status;

//   factory Habit.fromMap(Map<String, dynamic> json) => Habit(
//         title: json["title"],
//         status: json["status"],
//       );

//   Map<String, dynamic> toMap() => {
//         "title": title,
//         "status": status,
//       };
// }

class Nutrition {
  Nutrition({
    this.feeling,
    this.breakfast,
    this.lunch,
    this.snacks,
    this.dinner,
    this.nutritionSum,
  });

  String feeling;
  NutritionContent breakfast;
  NutritionContent lunch;
  NutritionContent snacks;
  NutritionContent dinner;
  double nutritionSum;

  factory Nutrition.fromMap(Map<String, dynamic> json) => Nutrition(
        feeling: json["feeling"],
        breakfast: NutritionContent.fromMap(json["breakfast"]),
        lunch: NutritionContent.fromMap(json["lunch"]),
        snacks: NutritionContent.fromMap(json["snacks"]),
        dinner: NutritionContent.fromMap(json["dinner"]),
        nutritionSum: json['nutritionSum'],
      );

  Map<String, dynamic> toMap() => {
        "feeling": feeling,
        "breakfast": breakfast.toMap(),
        "lunch": lunch.toMap(),
        "snacks": snacks.toMap(),
        "dinner": dinner.toMap(),
        "nutritionSum": nutritionSum,
      };
}

class NutritionContent {
  NutritionContent({
    this.content,
    this.calories,
  });

  String content;
  String calories;

  factory NutritionContent.fromMap(Map<String, dynamic> json) =>
      NutritionContent(
        content: json["content"],
        calories: json["calories"],
      );

  Map<String, dynamic> toMap() => {
        "content": content,
        "calories": calories,
      };
}
