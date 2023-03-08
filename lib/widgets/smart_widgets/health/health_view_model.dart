import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:vitalminds/core/app/app.locator.dart';
import 'package:vitalminds/core/app/logger.dart';
import 'package:vitalminds/core/models/habits_model.dart';
import 'package:vitalminds/core/models/health_model.dart';
import 'package:vitalminds/core/services/authentication_service.dart';
import 'package:vitalminds/core/services/firestore_service.dart';
import 'package:vitalminds/views/ui/setup_dialog_ui.dart';

class HealthViewModel extends FutureViewModel {
  Logger log;
  double nutritionSum = 0;
  double caloriesBurnedSum = 0;

  List selectedFoodItems = [];

  AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  FirestoreService _firestoreService = locator<FirestoreService>();
  HealthModel healthModel;
  DateTime selectedDate;
  String date;
  String uid;

  TextEditingController breakfastController = new TextEditingController();
  TextEditingController lunchController = new TextEditingController();
  TextEditingController snacksController = new TextEditingController();
  TextEditingController dinnerController = new TextEditingController();
  TextEditingController breakfastCalloriesController =
      new TextEditingController();
  TextEditingController lunchCalloriesController = new TextEditingController();
  TextEditingController snacksCalloriesController = new TextEditingController();
  TextEditingController dinnerCalloriesController = new TextEditingController();

  DialogService dialogService = locator<DialogService>();
  Map<String, double> calories = new Map();
  String feeling;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  SharedPreferences prefs;

  Future onSelectNotification(String payload) async {}

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {}

  Future setReminderOnPhone() async {
    WidgetsFlutterBinding.ensureInitialized();
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('logo');
    var initializationSettingsIOS = new IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = new InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  void cancelNotification() {
    bool habitsTracked = true;
    bool habitsNotificationsOn = true;
    if (prefs.getBool("notifications_on") != null) {
      habitsNotificationsOn = prefs.getBool("notifications_on") &&
          prefs.getBool("habits_notification");
    }
    for (var habit in healthModel.habits) {
      if (!habit.status) {
        habitsTracked = false;
        break;
      }
    }
    if (habitsTracked && habitsNotificationsOn) {
      flutterLocalNotificationsPlugin.cancel(1);
      log.i(
          "All habits have been tracked, so user won't get any notification today");
    }
  }

  void changeFeeling(String value) {
    healthModel.nutrition.feeling = value;
    notifyListeners();
  }

  Future addNutrition() async {
    DialogResponse response = await dialogService.showCustomDialog(
      variant: DialogType.nutrition,
      title: "Add Nutrition",
      barrierDismissible: true,
      // description: "Enter the task you want to be reminded of: ",
      mainButtonTitle: 'Enter',
    );
    if (response != null) {
      print(response);
      selectedFoodItems = response.data;
    }
    notifyListeners();
  }

  void onEditing(String name, String val, [bool first = false]) {
    if (!first && val.isEmpty) {
      nutritionSum -= calories[name];
      calories.remove(name);
    }
    if (calories.containsKey(name)) {
      nutritionSum -= calories[name];
      calories.update(
          name, (value) => double.tryParse(val.trim()) ?? calories[name]);
      nutritionSum += calories[name];
    } else {
      calories[name] = double.tryParse(val) ?? 0;
      nutritionSum += calories[name];
    }
    if (name.compareTo("breakfast") == 0) {
      breakfastCalloriesController.text =
          val.compareTo("Other") == 0 ? "0" : val;
      breakfastCalloriesController.selection = TextSelection(
          baseOffset: breakfastCalloriesController.text.length,
          extentOffset: breakfastCalloriesController.text.length);
    } else if (name.compareTo("lunch") == 0) {
      lunchCalloriesController.text = val.compareTo("Other") == 0 ? "0" : val;
      lunchCalloriesController.selection = TextSelection(
          baseOffset: lunchCalloriesController.text.length,
          extentOffset: lunchCalloriesController.text.length);
    } else if (name.compareTo("snacks") == 0) {
      snacksCalloriesController.text = val.compareTo("Other") == 0 ? "0" : val;

      snacksCalloriesController.selection = TextSelection(
          baseOffset: snacksCalloriesController.text.length,
          extentOffset: snacksCalloriesController.text.length);
    } else if (name.compareTo("dinner") == 0) {
      dinnerCalloriesController.text = val.compareTo("Other") == 0 ? "0" : val;

      dinnerCalloriesController.selection = TextSelection(
          baseOffset: dinnerCalloriesController.text.length,
          extentOffset: dinnerCalloriesController.text.length);
    }
    notifyListeners();
  }

  List<DropdownMenuItem> caloriesDropdown = [
    DropdownMenuItem(
      child: Text("50"),
      value: "50",
    ),
    DropdownMenuItem(
      child: Text("100"),
      value: "100",
    ),
    DropdownMenuItem(
      child: Text("150"),
      value: "150",
    ),
    DropdownMenuItem(
      child: Text("200"),
      value: "200",
    ),
    DropdownMenuItem(
      child: Text("250"),
      value: "250",
    ),
    DropdownMenuItem(
      child: Text("300"),
      value: "300",
    ),
    DropdownMenuItem(
      child: Text("350"),
      value: "350",
    ),
    DropdownMenuItem(
      child: Text("400"),
      value: "400",
    ),
    DropdownMenuItem(
      child: Text("500"),
      value: "500",
    ),
    DropdownMenuItem(
      child: Text("600"),
      value: "600",
    ),
    DropdownMenuItem(
      child: Text("700"),
      value: "700",
    ),
    DropdownMenuItem(
      child: Text("Other"),
      value: "Other",
    ),
  ];

  List<DropdownMenuItem> feelingItems = [
    DropdownMenuItem(
      child: Text(
        "Feeling overfilled",
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontFamily: "Roboto",
            fontStyle: FontStyle.normal,
            fontSize: 16.0),
        textAlign: TextAlign.left,
      ),
      value: "Feeling overfilled",
    ),
    DropdownMenuItem(
      child: Text(
        "Feeling nourished and healthy",
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontFamily: "Roboto",
            fontStyle: FontStyle.normal,
            fontSize: 16.0),
        textAlign: TextAlign.left,
      ),
      value: "Feeling nourished and healthy",
    ),
    DropdownMenuItem(
      child: Text(
        "Feeling energized",
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontFamily: "Roboto",
            fontStyle: FontStyle.normal,
            fontSize: 16.0),
        textAlign: TextAlign.left,
      ),
      value: "Feeling energized",
    ),
    DropdownMenuItem(
      child: Text(
        "Feeling tired",
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontFamily: "Roboto",
            fontStyle: FontStyle.normal,
            fontSize: 16.0),
        textAlign: TextAlign.left,
      ),
      value: "Feeling tired",
    ),
    DropdownMenuItem(
      child: Text(
        "Feeling gassy",
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontFamily: "Roboto",
            fontStyle: FontStyle.normal,
            fontSize: 16.0),
        textAlign: TextAlign.left,
      ),
      value: "Feeling gassy",
    ),
    DropdownMenuItem(
      child: Text(
        "Feeling lazy",
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontFamily: "Roboto",
            fontStyle: FontStyle.normal,
            fontSize: 16.0),
        textAlign: TextAlign.left,
      ),
      value: "Feeling lazy",
    ),
    DropdownMenuItem(
      child: Text(
        "Feeling hungry",
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontFamily: "Roboto",
            fontStyle: FontStyle.normal,
            fontSize: 16.0),
        textAlign: TextAlign.left,
      ),
      value: "Feeling hungry",
    ),
  ];

  HealthViewModel(DateTime date) {
    this.log = getLogger(this.runtimeType.toString());
    selectedDate = date;
    this.date = DateFormat('dd-MM-yyyy').format(selectedDate);
    print(_authenticationService.user);
    uid = _authenticationService.user.uid;
  }

  void habitsCheckboxController(bool value, int index) {
    healthModel.habits[index].status = value;
    cancelNotification();
    notifyListeners();
  }

  void deleteExcercise(int index) {
    healthModel.excercise.removeAt(index);
    if (healthModel.excercise.length > 0) {
      caloriesBurnedSum = 0;
      for (int index = 0; index < healthModel.excercise.length; index++) {
        caloriesBurnedSum += double.tryParse(
                healthModel.excercise[index].calories.split(" ")[0]) ??
            0.0;
      }
    }
    healthModel.totalCalories = caloriesBurnedSum;
    notifyListeners();
  }

  void deleteHabit(int index) {
    healthModel.habits.removeAt(index);
    notifyListeners();
  }

  Future editExcercise(int index) async {
    DialogResponse response = await dialogService.showCustomDialog(
      variant: DialogType.excercise,
      title: "Edit Exercise",
      data: [
        healthModel.excercise[index].name,
        healthModel.excercise[index].time.split(' ')[0],
        healthModel.excercise[index].calories.split(' ')[0]
      ],
      mainButtonTitle: 'Enter',
      barrierDismissible: true,
    );
    log.i("Exercise response: ${response?.data}");
    if (response != null) {
      healthModel.excercise[index].name = response.data[0];
      healthModel.excercise[index].time = response.data[1] + ' min';
      healthModel.excercise[index].calories = response.data[2] + ' cal';
      if (healthModel.excercise.length > 0) {
        caloriesBurnedSum = 0;
        for (int index = 0; index < healthModel.excercise.length; index++) {
          caloriesBurnedSum += double.tryParse(
                  healthModel.excercise[index].calories.split(" ")[0]) ??
              0.0;
        }
      }
      healthModel.totalCalories = caloriesBurnedSum;
    }
    notifyListeners();
  }

  Future addExcercise() async {
    DialogResponse response = await dialogService.showCustomDialog(
      variant: DialogType.excercise,
      title: "Add Exercise",
      mainButtonTitle: 'Enter',
      barrierDismissible: true,
    );
    log.i("To Do response: ${response?.data}");
    if (response != null) {
      healthModel.excercise.add(Excercise(
        name: response.data[0],
        time: response.data[1] + ' min',
        calories: response.data[2] + ' cal',
      ));
      if (healthModel.excercise.length > 0) {
        caloriesBurnedSum = 0;
        for (int index = 0; index < healthModel.excercise.length; index++) {
          caloriesBurnedSum += double.tryParse(
                  healthModel.excercise[index].calories.split(" ")[0]) ??
              0.0;
        }
      }
      healthModel.totalCalories = caloriesBurnedSum;
      print(caloriesBurnedSum);
    }

    notifyListeners();
  }

  Future dispose() async {
    if (healthModel != null) {
      healthModel.nutrition.breakfast.content = breakfastController.text;
      healthModel.nutrition.breakfast.calories =
          breakfastCalloriesController.text;
      healthModel.nutrition.lunch.content = lunchController.text;
      healthModel.nutrition.lunch.calories = lunchCalloriesController.text;
      healthModel.nutrition.snacks.content = snacksController.text;
      healthModel.nutrition.snacks.calories = snacksCalloriesController.text;
      healthModel.nutrition.dinner.content = dinnerController.text;
      healthModel.nutrition.dinner.calories = dinnerCalloriesController.text;
      healthModel.nutrition.nutritionSum = nutritionSum;
      await _firestoreService.updateHealthData(uid, date, healthModel);
    }
    super.dispose();
  }

  @override
  Future futureToRun() async {
    setBusy(true);
    prefs = await SharedPreferences.getInstance();
    setReminderOnPhone();
    var flag = await _firestoreService.isDataPresent(uid, date, 'health');
    if (!flag) {
      List<Habit> habits =
          await _firestoreService.getHabits(uid, selectedDate.weekday);
      healthModel = new HealthModel(
        habits: habits,
        nutrition: Nutrition(
          breakfast: NutritionContent(),
          lunch: NutritionContent(),
          snacks: NutritionContent(),
          dinner: NutritionContent(),
        ),
        excercise: [],
      );
    } else {
      List<Habit> habits =
          await _firestoreService.getHabits(uid, selectedDate.weekday);
      healthModel = await _firestoreService.getHealthData(uid, date);
      habits.forEach((allHabit) {
        // if (!healthModel.habits.contains(element)) {
        //   healthModel.habits.add(element);
        // }
        bool isUniqueAdd = true;
        healthModel.habits.forEach((habit) {
          if (habit.title.compareTo(allHabit.title) == 0) {
            isUniqueAdd = false;
          }
        });
        if (isUniqueAdd) {
          healthModel.habits.add(allHabit);
        }
      });
    }

    if (healthModel.nutrition.breakfast != null) {
      breakfastController.text = healthModel.nutrition.breakfast.content;
      breakfastCalloriesController.text =
          healthModel.nutrition.breakfast.calories;
      onEditing("breakfast", breakfastCalloriesController.text, true);
    }
    if (healthModel.nutrition.lunch != null) {
      lunchController.text = healthModel.nutrition.lunch.content;
      lunchCalloriesController.text = healthModel.nutrition.lunch.calories;
      onEditing("lunch", lunchCalloriesController.text, true);
    }
    if (healthModel.nutrition.snacks != null) {
      snacksController.text = healthModel.nutrition.snacks.content;
      snacksCalloriesController.text = healthModel.nutrition.snacks.calories;
      onEditing("snacks", snacksCalloriesController.text, true);
    }
    if (healthModel.nutrition.dinner != null) {
      dinnerController.text = healthModel.nutrition.dinner.content;
      dinnerCalloriesController.text = healthModel.nutrition.dinner.calories;
      onEditing("dinner", dinnerCalloriesController.text, true);
    }

    if (healthModel.excercise.length > 0) {
      for (int index = 0; index < healthModel.excercise.length; index++) {
        caloriesBurnedSum += double.tryParse(
                healthModel.excercise[index].calories.split(" ")[0]) ??
            0.0;
      }
    }
    notifyListeners();
    cancelNotification();

    setBusy(false);
  }
}
