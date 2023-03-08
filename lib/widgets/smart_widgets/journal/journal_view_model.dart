import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:vitalminds/core/app/app.locator.dart';
import 'package:vitalminds/core/app/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:vitalminds/core/services/authentication_service.dart';
import 'package:vitalminds/widgets/dumb_widgets/Themes.dart';
import 'package:vitalminds/widgets/dumb_widgets/edit_people_and_relationships/edit_people_and_relationships_widget.dart';

class PeopleAndRelationshipController {
  TextEditingController person_controller;
  int relationship;
  TextEditingController notes_controller;

  PeopleAndRelationshipController(
      {this.person_controller, this.relationship, this.notes_controller});
}

class JournalViewModel extends FutureViewModel {
  //All important services used throughout
  Logger log;
  DateTime selectedDate = DateTime.now();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  SharedPreferences prefs;
  final databaseReference = FirebaseFirestore.instance;
  NavigationService navigationService = locator<NavigationService>();
  AuthenticationService authenticationService =
      locator<AuthenticationService>();

  //All fields related to mood today
  int moodMorning;
  int moodAfternoon;
  int moodEvening;
  TextEditingController notesMorning = new TextEditingController();
  TextEditingController notesAfternoon = new TextEditingController();
  TextEditingController notesEvening = new TextEditingController();

  //All fields related to grateful for
  List<TextEditingController> gratefulForControllers = [];
  List<bool> gratefullShowTextfield = [];
  List gratefulFor = [];

  //All fields related to people and relationships
  List peopleAndRelationshipsArray = [];

  List<PeopleAndRelationshipController> peopleAndRelationshipsControllers = [];
  List names = [];

  //All fields related to thought of the day
  List thoughtOfTheDayControllers = [];
  List thoughtOfTheDay = [];

  //All fields related to money matters
  double income;
  double expenditure;
  double netpl;
  TextEditingController incomecontroller = new TextEditingController();
  TextEditingController expenditurecontroller = new TextEditingController();

  //all functions related to mood today
  void changeMood(String type, int moodValue) {
    if (type == "Morning") {
      moodMorning = moodValue;
    }
    if (type == "Afternoon") {
      moodAfternoon = moodValue;
    }
    if (type == "Evening") {
      moodEvening = moodValue;
    }
    notifyListeners();
  }

  //All functions related to grateful for
  void addGratefulForController() {
    TextEditingController controller = new TextEditingController();
    gratefulForControllers.add(controller);
    gratefullShowTextfield.add(false);
    notifyListeners();
  }

  void deleteGratefulForController(int index) {
    gratefulForControllers.removeAt(index);
    gratefullShowTextfield.removeAt(index);
    notifyListeners();
  }

  //All functions related to people and relationships
  void addPeopleAndRelationships() {
    TextEditingController personController = new TextEditingController();
    TextEditingController notesController = new TextEditingController();
    peopleAndRelationshipsControllers.add(PeopleAndRelationshipController(
      person_controller: personController,
      relationship: -1,
      notes_controller: notesController,
    ));
    notifyListeners();
  }

  Future createPeopleAndRelationshipsArray() async {
    peopleAndRelationshipsArray = [];
    for (int index = 0;
        index < peopleAndRelationshipsControllers.length;
        index++) {
      peopleAndRelationshipsArray.add({
        "person":
            peopleAndRelationshipsControllers[index].person_controller.text,
        "relationship": peopleAndRelationshipsControllers[index].relationship,
        "notes": peopleAndRelationshipsControllers[index].notes_controller.text,
      });
    }
    notifyListeners();
  }

  void deletePeopleAndRelationships(int index) {
    peopleAndRelationshipsControllers.removeAt(index);
    notifyListeners();
  }

  void goToEditRelationshipsPage(viewModel, int index) {
    navigationService.navigateToView(EditPeopleAndRelationshipsWidget(
      viewModel: viewModel,
      currentDate: selectedDate,
      position: index,
    ));
  }

  //All functions related to thought of the day
  void addThoughtOfTheDayController() {
    TextEditingController controller = new TextEditingController();
    thoughtOfTheDayControllers.add(controller);
    notifyListeners();
  }

  void deleteThoughtOfTheDayController(int index) {
    thoughtOfTheDayControllers.removeAt(index);
    notifyListeners();
  }

  //All functions related to money matters
  void calcNetpl() {
    if (income == null && expenditure != null)
      netpl = 0 - expenditure;
    else if (income != null && expenditure == null)
      netpl = income;
    else if (income == null && expenditure == null)
      netpl = null;
    else
      netpl = income - expenditure;
    notifyListeners();
  }

  void enterMoneyMatterAlert(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return BackdropFilter(
            filter: new ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
            child: AlertDialog(
              backgroundColor: Color.fromRGBO(236, 236, 236, 0.95),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              title: Center(
                child: Text('Enter Income and Expenditure',
                    style: TextStyle(
                        color: const Color(0xff273348),
                        fontWeight: FontWeight.w700,
                        fontFamily: "Roboto",
                        fontStyle: FontStyle.normal,
                        fontSize: 16.0)),
              ),
              content: Container(
                height: MediaQuery.of(context).size.height * 0.30,
                child: Column(
                  children: [
                    Text("Please enter your income and expenditure below :",
                        style: TextStyle(
                            fontFamily: "Roboto",
                            color: const Color(0xff273348),
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 13.5)),
                    TextField(
                      cursorColor: Themes.color,
                      keyboardType: TextInputType.number,
                      controller: incomecontroller,
                      decoration: new InputDecoration(
                        prefixText: "₹\t",
                        prefixStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: "Roboto",
                          fontStyle: FontStyle.normal,
                        ),
                        helperText: "Enter your income here",
                        helperStyle: TextStyle(
                            color: const Color(0xffadb7c4),
                            fontWeight: FontWeight.w400,
                            fontFamily: "Roboto",
                            fontStyle: FontStyle.normal,
                            fontSize: 12.0),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xffadb7c4),
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Themes.color,
                          ),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xffadb7c4),
                          ),
                        ),
                      ),
                    ),
                    TextField(
                      cursorColor: Themes.color,
                      keyboardType: TextInputType.number,
                      controller: expenditurecontroller,
                      decoration: new InputDecoration(
                        prefixText: "₹\t",
                        prefixStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: "Roboto",
                          fontStyle: FontStyle.normal,
                        ),
                        helperText: "Enter your expenditure here",
                        helperStyle: TextStyle(
                            color: const Color(0xffadb7c4),
                            fontWeight: FontWeight.w400,
                            fontFamily: "Roboto",
                            fontStyle: FontStyle.normal,
                            fontSize: 12.0),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xffadb7c4),
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xff5a5ed0),
                          ),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xffadb7c4),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              titlePadding: const EdgeInsets.all(20.0),
              contentPadding:
                  const EdgeInsets.only(left: 20, right: 20, top: 20),
              actionsPadding: const EdgeInsets.only(left: 20, right: 20),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 5, right: 5),
                      child: TextButton(
                        child: Text('CONFIRM',
                            style: TextStyle(
                                color: Themes.color,
                                fontWeight: FontWeight.w700,
                                fontFamily: "Roboto",
                                fontStyle: FontStyle.normal,
                                fontSize: 14.0)),
                        onPressed: () {
                          income = double.tryParse(incomecontroller.text);
                          expenditure =
                              double.tryParse(expenditurecontroller.text);
                          calcNetpl();
                          cancelNotification();
                          notifyListeners();
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: TextButton(
                        child: const Text('CANCEL',
                            style: TextStyle(
                                color: Colors.pink,
                                fontWeight: FontWeight.w700,
                                fontFamily: "Roboto",
                                fontStyle: FontStyle.normal,
                                fontSize: 14.0)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  //All functions related to notifications

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
    bool journalsNotificationsOn = true;
    if (prefs.getBool("notifications_on") != null) {
      journalsNotificationsOn = prefs.getBool("notifications_on") &&
          prefs.getBool("journal_notification");
    }
    if (!(moodMorning == null &&
        moodAfternoon == null &&
        moodEvening == null &&
        notesMorning.text == '' &&
        notesAfternoon.text == '' &&
        notesEvening.text == '' &&
        income == null &&
        expenditure == null &&
        gratefulFor.isEmpty &&
        thoughtOfTheDay.isEmpty &&
        peopleAndRelationshipsArray.isEmpty &&
        journalsNotificationsOn)) {
      flutterLocalNotificationsPlugin.cancel(3);
      log.i("Cancelled all journal notifications");
      notifyListeners();
    }
  }

//All general functions
  void goBack() {
    navigationService.back();
  }

  Future updateData() async {
    gratefulFor = [];
    thoughtOfTheDay = [];
    for (int index = 0; index < gratefulForControllers.length; index++) {
      gratefulFor.add(gratefulForControllers[index].text.trim());
    }
    for (int index = 0; index < thoughtOfTheDayControllers.length; index++) {
      thoughtOfTheDay.add(thoughtOfTheDayControllers[index].text);
    }
    await databaseReference
        .collection('users')
        .doc(authenticationService.user.uid)
        .collection('Journals')
        .doc('${DateFormat('dd-MM-yyyy').format(selectedDate)}')
        .set({
      'mood_morning': moodMorning,
      'mood_afternoon': moodAfternoon,
      'mood_evening': moodEvening,
      'notes_morning': notesMorning.text,
      'notes_afternoon': notesAfternoon.text,
      'notes_evening': notesEvening.text,
      'income_today': income,
      'expenditure_today': expenditure,
      'grateful_for': gratefulFor,
      'thought_of_the_day': thoughtOfTheDay,
      'peopleAndRelationships': peopleAndRelationshipsArray
    }, SetOptions(merge: true)).then((_) {
      log.i("Journal data updated");
    }).catchError((e) {
      log.e(e.toString());
    });
    await databaseReference
        .collection('users')
        .doc(authenticationService.user.uid)
        .collection('Journals')
        .doc('names')
        .set({'names': names}, SetOptions(merge: true)).then((_) {
      log.i("Names updated");
    }).catchError((e) {
      log.e(e.toString());
    });
  }

  Future getData() async {
    await databaseReference
        .collection('users')
        .doc(authenticationService.user.uid)
        .collection('Journals')
        .get()
        .then((value) {
      if (value.docs.length == 0) {
        log.i("User is entering journal entry for the first time");
      } else {
        for (var doc in value.docs) {
          if (doc.id == DateFormat('dd-MM-yyyy').format(selectedDate)) {
            log.i("Journal entry for this date is already present");
            moodMorning = doc.data()['mood_morning'];
            moodAfternoon = doc.data()['mood_afternoon'];
            moodEvening = doc.data()['mood_evening'];
            notesMorning.text = doc.data()['notes_morning'];
            notesAfternoon.text = doc.data()['notes_afternoon'];
            notesEvening.text = doc.data()['notes_evening'];
            income = doc.data()['income_today'];
            expenditure = doc.data()['expenditure_today'];
            notifyListeners();
            calcNetpl();
            gratefulFor = doc.data()['grateful_for'];
            for (var text in gratefulFor) {
              TextEditingController controller = new TextEditingController();
              controller.text = text;
              gratefulForControllers.add(controller);
              gratefullShowTextfield.add(true);
            }
            thoughtOfTheDay = doc.data()['thought_of_the_day'];
            for (var text in thoughtOfTheDay) {
              TextEditingController controller = new TextEditingController();
              controller.text = text;
              thoughtOfTheDayControllers.add(controller);
            }
            peopleAndRelationshipsArray = doc.data()['peopleAndRelationships'];
            for (var entry in peopleAndRelationshipsArray) {
              TextEditingController personController =
                  new TextEditingController();
              TextEditingController notesController =
                  new TextEditingController();
              int relationship = entry['relationship'];
              personController.text = entry['person'];
              notesController.text = entry['notes'];
              peopleAndRelationshipsControllers
                  .add(PeopleAndRelationshipController(
                person_controller: personController,
                relationship: relationship,
                notes_controller: notesController,
              ));
            }
            notifyListeners();
          }
        }
      }
      log.i("Journal data fetched");
      return value;
    }).catchError((e) {
      log.e(e.toString());
    });
  }

  Future getNames() async {
    await databaseReference
        .collection('users')
        .doc(authenticationService.user.uid)
        .collection('Journals')
        .get()
        .then((value) {
      if (value.docs.length != 0) {
        for (var doc in value.docs) {
          if (doc.id == "names") {
            names = doc.data()['names'];
            log.i("names : " + names.toString());
            notifyListeners();
          }
        }
      }
      log.i("Names fetched");
      return value;
    }).catchError((e) {
      log.e(e.toString());
    });
  }

  JournalViewModel(val) {
    this.log = getLogger(this.runtimeType.toString());
    this.selectedDate = val;
    log.i("The selected date is : $selectedDate");
  }
  @override
  Future dispose() async {
    await updateData();
    cancelNotification();
    super.dispose();
  }

  @override
  Future futureToRun() async {
    await getData();
    await getNames();
    prefs = await SharedPreferences.getInstance();
    setReminderOnPhone();
    throw UnimplementedError();
  }

  void deleteAllEmptyJournalEntries() {
    if (gratefulForControllers.length > 0) {
      for (var i = 0; i < gratefulForControllers.length; i++) {
        if (gratefulForControllers[i].text == "" ||
            gratefulForControllers[i].text == null) {
          deleteGratefulForController(i);
          i -= 1;
        }
      }
    }

    if (thoughtOfTheDayControllers.length > 0) {
      for (var i = 0; i < thoughtOfTheDayControllers.length; i++) {
        if (thoughtOfTheDayControllers[i].text == "" ||
            thoughtOfTheDayControllers[i].text == null) {
          deleteThoughtOfTheDayController(i);
          i -= 1;
        }
      }
    }

    if (peopleAndRelationshipsControllers.length > 0) {
      for (var i = 0; i < peopleAndRelationshipsControllers.length; i++) {
        if (peopleAndRelationshipsControllers[i].person_controller.text == "" ||
            peopleAndRelationshipsControllers[i].person_controller.text ==
                null) {
          peopleAndRelationshipsControllers.removeAt(i);
          i -= 1;
        }
      }
      createPeopleAndRelationshipsArray();
    }

    notifyListeners();
  }
}
