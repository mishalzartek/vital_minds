import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:vitalminds/core/app/app.locator.dart';
import 'package:vitalminds/core/app/logger.dart';
import 'package:vitalminds/core/services/authentication_service.dart';
import 'package:vitalminds/widgets/dumb_widgets/Themes.dart';

class AnalyticsPageViewModel extends FutureViewModel {
  //basic services used
  Logger log;
  DateTime currentDate = DateTime.now();
  List daysList = [];
  String uid;
  bool loading = true;
  final databaseReference = FirebaseFirestore.instance;
  AuthenticationService authenticationService =
      locator<AuthenticationService>();

  //all fields related to mood graph
  List morningMoodList = [];
  List afternoonMoodList = [];
  List eveningMoodList = [];
  List moodGraphList;
  double maximumMorningMood = 0.0;
  double maximumAfternoonMood = 0.0;
  double maximumEveningMood = 0.0;

  //all fields related to Excercise & Nutrition
  List nutritionCaloriesGraphList = [];
  List exerciseCaloriesGraphList = [];
  List caloriesGraphList;
  double maximumCaloriesGained = 0.0;
  double maximumCaloriesBurned = 0.0;

  //all fields related to habits graph
  List habitsList = [];
  List habitsData = [];

  //all fields related to money graph
  List incomeList = [];
  List expenditureList = [];
  List moneyGraphList;
  double maximumIncomeValue = 0.0;
  double maximumExpenditureValue = 0.0;

  //all fields related to theme
  Color maxColor = Themes.color == Color.fromRGBO(143, 41, 116, 1)
      ? Color(0xffCA6BB1)
      : Themes.color == Color.fromRGBO(62, 147, 194, 1)
          ? Color(0xff91D3D8)
          : Themes.color == Color.fromRGBO(101, 163, 182, 1)
              ? Color(0xff8DC9DB)
              : Themes.color == Color.fromRGBO(0, 148, 230, 1)
                  ? Color(0xff99CFEC)
                  : Themes.color == Color.fromRGBO(216, 142, 99, 1)
                      ? Color(0xffE9B698)
                      : Themes.color == Color(0xff5a5ed0)
                          ? Color(0xff9498F3)
                          : Colors.white;

  Future<void> selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Themes.color, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Themes.color, // button text color
              ),
            ),
          ),
          child: child,
        );
      },
    );
    if (pickedDate != null && pickedDate != currentDate) {
      currentDate = pickedDate;
      await printResult(currentDate);
    }
  }

  Future goToPrevDate() async {
    currentDate = currentDate.subtract(Duration(days: 1));
    if (currentDate.isAfter(DateTime.utc(DateTime.now().year, 1, 1))) {
      await printResult(currentDate);
    } else {
      currentDate = currentDate.add(Duration(days: 1));
      notifyListeners();
      Fluttertoast.showToast(
          msg: "Date cannot be decreased!", gravity: ToastGravity.BOTTOM);
    }
  }

  Future goToNextDate() async {
    currentDate = currentDate.add(Duration(days: 1));
    if (currentDate.isBefore(DateTime.now())) {
      await printResult(currentDate);
    } else {
      Fluttertoast.showToast(
          msg: "Date greater than Today's Date!", gravity: ToastGravity.BOTTOM);
      currentDate = currentDate.subtract(Duration(days: 1));
    }
  }

  void changeLoading() {
    loading = !loading;
    notifyListeners();
  }

  Future createDaysList(DateTime currentDate) async {
    log.i('current date ' + currentDate.toString());
    daysList = [];
    CollectionReference journal = FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("Journals");
    CollectionReference<Map<String, dynamic>> health = FirebaseFirestore
        .instance
        .collection("users")
        .doc(uid)
        .collection("health");
    CollectionReference<Map<String, dynamic>> habits = FirebaseFirestore
        .instance
        .collection("users")
        .doc(uid)
        .collection("habits");
    int weekDay = currentDate.weekday;
    for (int i = weekDay - 1; i >= 0; i--) {
      daysList.add(DateFormat('dd-MM-yyyy')
          .format(currentDate.subtract(Duration(days: i))));
    }
    moodGraphList = await getmoodGraphList(journal);
    moneyGraphList = await getmoneyGraphList(journal);
    print("test2");
    caloriesGraphList = await getCaloriesGraphList(health);
    habitsData = await getHabitsGraphData(habits);

    notifyListeners();
    return [moodGraphList, habitsData, moneyGraphList, caloriesGraphList];
  }

  Future getCaloriesGraphList(health) async {
    nutritionCaloriesGraphList = List.filled(7, 0.0);
    exerciseCaloriesGraphList = List.filled(7, 0.0);
    print("test3");
    await health.get().then((value) {
      print('test1');
      if (value.docs.length > 0) {
        for (int index = 0; index < daysList.length; index++) {
          for (var doc in value.docs) {
            if (doc.id == daysList[index]) {
              exerciseCaloriesGraphList[index] = doc['totalCalories'] ?? 0.0;
              nutritionCaloriesGraphList[index] =
                  doc['nutrition']["nutritionSum"] ?? 0.0;

              print('test');
              print(doc["totalCalories"]);
              print(doc['nutrition']["nutritionSum"]);
            }
          }
        }
      }
    });
    notifyListeners();
    return [nutritionCaloriesGraphList, exerciseCaloriesGraphList];
  }

  Future getmoodGraphList(journal) async {
    morningMoodList = List.filled(7, -1);
    afternoonMoodList = List.filled(7, -1);
    eveningMoodList = List.filled(7, -1);
    await journal.get().then((value) {
      if (value.docs.length > 0) {
        for (int index = 0; index < daysList.length; index++) {
          for (var doc in value.docs) {
            if (doc.id == daysList[index]) {
              morningMoodList[index] = doc['mood_morning'] ?? -1;
              afternoonMoodList[index] = doc['mood_afternoon'] ?? -1;
              eveningMoodList[index] = doc['mood_evening'] ?? -1;
            }
          }
        }
      }
    });
    for (int index = 0; index < morningMoodList.length; index++) {
      morningMoodList[index] = getEmoticonValueFromMood(morningMoodList[index]);
      afternoonMoodList[index] =
          getEmoticonValueFromMood(afternoonMoodList[index]);
      eveningMoodList[index] = getEmoticonValueFromMood(eveningMoodList[index]);
    }
    notifyListeners();
    return [morningMoodList, afternoonMoodList, eveningMoodList];
  }

  Future getmoneyGraphList(journal) async {
    incomeList = List.filled(7, 0.0);
    expenditureList = List.filled(7, 0.0);
    await journal.get().then((value) {
      if (value.docs.length > 0) {
        for (int index = 0; index < daysList.length; index++) {
          for (var doc in value.docs) {
            if (doc.id == daysList[index]) {
              incomeList[index] = doc['income_today'] ?? 0.0;
              expenditureList[index] = doc['expenditure_today'] ?? 0.0;
            }
          }
        }
      }
    });
    notifyListeners();
    return [incomeList, expenditureList];
  }

  Future getHabitsGraphData(habits) async {
    habitsData = [];
    List allHabitsDaysList = [];
    habitsList = [[], [], [], [], [], [], []];
    List allHabits = [];
    await habits.get().then((value) {
      if (value.docs.length > 0) {
        for (int index = 0; index < daysList.length; index++) {
          allHabitsDaysList = [];
          for (var doc in value.docs) {
            if (doc.id == "habits" && doc['habits'] != null) {
              for (var habit in doc.data()['habits']) {
                print(habit["title"]);
                if (habit['status']) {
                  habitsList[index].add(habit['title']);
                }
                allHabits.add(habit['title']);
                allHabitsDaysList.add(habit["days"]);
              }
            }
          }
        }
      }
    });
    List habitsOnMonday = habitsList[0];
    List habitsOnTuesday = habitsList[1];
    List habitsOnWednesday = habitsList[2];
    List habitsOnThursday = habitsList[3];
    List habitsOnFriday = habitsList[4];
    List habitsOnSaturday = habitsList[5];
    List habitsOnSunday = habitsList[6];

    List habitsName = allHabits.toSet().toList();
    for (int position = 0; position < habitsName.length; position++) {
      habitsData.add({
        "habit": habitsName[position],
        "active": [
          habitsOnMonday.contains(habitsName[position]),
          habitsOnTuesday.contains(habitsName[position]),
          habitsOnWednesday.contains(habitsName[position]),
          habitsOnThursday.contains(habitsName[position]),
          habitsOnFriday.contains(habitsName[position]),
          habitsOnSaturday.contains(habitsName[position]),
          habitsOnSunday.contains(habitsName[position])
        ],
        "days": allHabitsDaysList[position],
      });
      for (var habit in allHabits) {
        if (!habitsName.contains(habit)) {
          habitsData.add({
            "habit": habit,
            "active": [false, false, false, false, false, false, false],
            "days": []
          });
        }
      }
    }
    notifyListeners();
    return habitsData;
  }

  double getEmoticonValueFromMood(int mood) {
    double emoticonValue;
    switch (mood) {
      case 0:
        {
          emoticonValue = 0.5 * 16.666666667;
          notifyListeners();
          break;
        }
      case 1:
        {
          emoticonValue = 2.5 * 16.666666667;
          notifyListeners();
          break;
        }
      case 2:
        {
          emoticonValue = 4.5 * 16.666666667;
          notifyListeners();
          break;
        }
      case 3:
        {
          emoticonValue = 6.5 * 16.666666667;
          notifyListeners();
          break;
        }
      case 4:
        {
          emoticonValue = 8.5 * 16.666666667;
          notifyListeners();
          break;
        }
      case 5:
        {
          emoticonValue = 10.5 * 16.666666667;
          notifyListeners();
          break;
        }
      default:
        {
          emoticonValue = 0.0;
          notifyListeners();
          break;
        }
    }
    return emoticonValue;
  }

  Future printResult(DateTime currentDate) async {
    await createDaysList(currentDate);
    print('tett4');
    log.i("Mood Graph Data" + moodGraphList.toString());
    log.i("Money Graph Data" + moneyGraphList.toString());
    log.i("Habits Graph Data" + habitsData.toString());
    maximumIncomeValue =
        moneyGraphList[0].reduce((curr, next) => curr > next ? curr : next);
    maximumExpenditureValue =
        moneyGraphList[1].reduce((curr, next) => curr > next ? curr : next);
    maximumCaloriesGained =
        caloriesGraphList[0].reduce((curr, next) => curr > next ? curr : next);
    maximumCaloriesBurned =
        caloriesGraphList[1].reduce((curr, next) => curr > next ? curr : next);

    maximumMorningMood =
        morningMoodList.reduce((curr, next) => curr > next ? curr : next);
    maximumAfternoonMood =
        afternoonMoodList.reduce((curr, next) => curr > next ? curr : next);
    maximumEveningMood =
        eveningMoodList.reduce((curr, next) => curr > next ? curr : next);
    log.i("Maximum Income : " + maximumIncomeValue.toString());
    log.i("Maximum Expenditure : " + maximumExpenditureValue.toString());
    log.i("Maximum morning mood value : " + maximumMorningMood.toString());
    log.i("Maximum afternoon mood value : " + maximumAfternoonMood.toString());
    log.i("Maximum evening mood value : " + maximumEveningMood.toString());
    notifyListeners();
  }

  AnalyticsPageViewModel() {
    uid = authenticationService.user.uid;
    this.log = getLogger(this.runtimeType.toString());
  }

  @override
  Future futureToRun() async {
    await printResult(currentDate).whenComplete(() => changeLoading());
    notifyListeners();
    throw UnimplementedError();
  }
}
