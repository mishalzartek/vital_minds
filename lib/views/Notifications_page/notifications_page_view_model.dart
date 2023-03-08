import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:vitalminds/core/app/app.locator.dart';
import 'package:vitalminds/views/settings_page/settings_page_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationsPageViewModel extends BaseViewModel {
  NavigationService navigationService = locator<NavigationService>();
  List titles = ["Habits", "Reminders", "Journal"];
  List checkValues = [true, true, true];
  bool switchValue = true;
  int remindersLength = 0;
  int habitsLength = 0;
  bool moodRecorded = false;
  SharedPreferences prefs;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
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

  Future getNotificationSettingsData() async {
    prefs = await SharedPreferences.getInstance();
    var noOfReminders = prefs.getInt("reminders_length");
    var value = prefs.getBool("notifications_on");
    if (value != null) {
      switchValue = value;
      checkValues[0] = prefs.getBool("habits_notification");
      checkValues[1] = prefs.getBool("reminders_notification");
      checkValues[2] = prefs.getBool("journal_notification");
    }
    if (noOfReminders != null) {
      remindersLength = noOfReminders;
    }
    notifyListeners();
  }

  Future saveNotificationSettingsData() async {
    prefs = await SharedPreferences.getInstance();
    prefs.setBool("notifications_on", switchValue);
    prefs.setBool("habits_notification", checkValues[0]);
    prefs.setBool("reminders_notification", checkValues[1]);
    prefs.setBool("journal_notification", checkValues[2]);
  }

  void navigateToProfilePage(context) {
    navigationService.navigateWithTransition(SettingsPageView(), transition: 'leftToRight');
  }

  void changeSwitchValue(bool value) {
    switchValue = value;
    if (!value) deleteNotification(3);
    notifyListeners();
  }

  void changeCheckValue(bool value, int i) {
    checkValues[i] = value;
    notifyListeners();
  }

  Future deleteNotification(int type) async {
    if (type == 0) {
        flutterLocalNotificationsPlugin.cancel(1);
    }
    if (type == 1) {
      for (int i = 0; i < remindersLength; i++) {
        int id = int.tryParse("2" + i.toString());
        flutterLocalNotificationsPlugin.cancel(id);
      }
    }
    if (type == 2) {
      flutterLocalNotificationsPlugin.cancel(3);
    }
    if (type == 3) {
      flutterLocalNotificationsPlugin.cancelAll();
    }
  }

  NotificationsPageViewModel() {
    setReminderOnPhone();
    getNotificationSettingsData();
  }
}
