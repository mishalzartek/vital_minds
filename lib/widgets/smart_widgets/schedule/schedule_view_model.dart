import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:vitalminds/core/app/app.locator.dart';
import 'package:vitalminds/core/app/logger.dart';
import 'package:vitalminds/core/models/schedule_model.dart';
import 'package:vitalminds/core/services/authentication_service.dart';
import 'package:vitalminds/core/services/firestore_service.dart';
import 'package:vitalminds/views/ui/setup_dialog_ui.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class ScheduleViewModel extends FutureViewModel {
  Logger log;
  bool dateCheck = false;
  DialogService dialogService = locator<DialogService>();
  FirestoreService _firestoreService = locator<FirestoreService>();
  AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  NavigationService navigationService = locator<NavigationService>();
  ScheduleModel scheduleModel;
  bool remindersNotificationsOn = true;
  String date;
  bool added = false;
  String uid;
  DateTime selectedDate;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  SharedPreferences prefs;
  ScheduleViewModel(DateTime date) {
    this.log = getLogger(this.runtimeType.toString());
    selectedDate = date;
    this.date = DateFormat('dd-MM-yyyy').format(selectedDate);
    uid = _authenticationService.user.uid;
  }

  Future dispose() async {
    await _firestoreService.updateScheduleData(uid, date, scheduleModel, added);
    prefs.setInt("reminders_length", scheduleModel.reminders.length);
    super.dispose();
  }

  void updateToDoCheckbox(bool value, int index) {
    scheduleModel.todo[index].status = value;
    notifyListeners();
  }

  void updateReminderCheckbox(bool value, int index) {
    scheduleModel.reminders[index].status = value;
    notifyListeners();
  }

  Future deleteReminder(int index) async {
    if (remindersNotificationsOn) {
      int id = int.tryParse("2" + index.toString());
      log.i("Cancelling reminder : " + scheduleModel.reminders[index].title);
      await flutterLocalNotificationsPlugin.cancel(id);
    }
    scheduleModel.reminders.removeAt(index);
    notifyListeners();
  }

  Future onSelectNotification(String payload) async {
    //Getting details on if the app was launched via a notification created by this plugin
    // final NotificationAppLaunchDetails notificationAppLaunchDetails =
    //     await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    // if (notificationAppLaunchDetails.didNotificationLaunchApp) {
    //   navigationService.replaceWithTransition(
    //       DetailsPageTabBarView(selectedDate: DateTime.now()));
    // }
    // showDialog(
    //   context: context,
    //   builder: (_) {
    //     return new AlertDialog(
    //       title: Text("PayLoad"),
    //       content: Text("Payload : $payload"),
    //     );
    //   },
    // );
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page
  }

  Future _showNotificationWithDefaultSound(int index) async {
    int id = int.tryParse("2" + index.toString());
    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      'You have ${scheduleModel.reminders[index].title} in your reminders today',
      htmlFormatBigText: true,
      contentTitle: 'New Reminder!',
      htmlFormatContentTitle: true,
      summaryText: '',
      htmlFormatSummaryText: true,
    );
    tz.initializeTimeZones();
    String currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        '2', 'schedule',
        channelDescription: 'Notifications for reminders',
        importance: Importance.max,
        priority: Priority.high,
        styleInformation: bigTextStyleInformation);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    DateTime scheduledTime;
    String date = DateFormat('yyyy-MM-dd').format(selectedDate);
    String time = scheduleModel.reminders[index].time.split(" ")[0];
    if (scheduleModel.reminders[index].time.contains("AM")) {
      if (time.split(":")[0] == '12') {
        scheduledTime = DateTime.parse("$date 00:${time.split(":")[1]}:00");
      } else {
        scheduledTime = DateTime.parse(
            "$date ${time.split(":")[0]}:${time.split(":")[1]}:00");
      }
    } else if (scheduleModel.reminders[index].time.contains("PM")) {
      scheduledTime = DateTime.parse(
          "$date ${time.split(":")[0]}:${time.split(":")[1]}:00");
      if (time.split(":")[0] != '12')
        scheduledTime = scheduledTime.add(Duration(hours: 12));
    }
    log.i(tz.TZDateTime.from(scheduledTime, tz.local).toString());
    if (scheduledTime.isAfter(DateTime.now())) {
      await flutterLocalNotificationsPlugin.zonedSchedule(
          id,
          'New Reminder!',
          'You have ${scheduleModel.reminders[index].title} in your reminders today',
          tz.TZDateTime.from(scheduledTime, tz.local),
          platformChannelSpecifics,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime);
      int hoursLeft = scheduledTime.difference(DateTime.now()).inHours;
      int minutesLeft =
          scheduledTime.difference(DateTime.now()).inMinutes - hoursLeft * 60;
      int secondsLeft = scheduledTime.difference(DateTime.now()).inSeconds -
          hoursLeft * 3600 -
          minutesLeft * 60;
      Fluttertoast.showToast(
          msg:
              'Reminder set at $hoursLeft h $minutesLeft min $secondsLeft sec from now',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      scheduleModel.reminders.removeAt(index);
      Fluttertoast.showToast(
          msg: 'Cannot set a reminder for a time before the current time',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

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

  Future editReminder(int index) async {
    DialogResponse response = await dialogService.showCustomDialog(
      variant: DialogType.reminder,
      title: "Edit Reminder",
      data: [
        scheduleModel.reminders[index].title,
        scheduleModel.reminders[index].time
      ],
      mainButtonTitle: 'Enter',
      barrierDismissible: true,
    );
    log.i("Reminder response: ${response?.data}");
    if (response != null) {
      scheduleModel.reminders[index].title = response.data[0];
      scheduleModel.reminders[index].time = response.data[1];
      if (remindersNotificationsOn) {
        log.i("Resetting reminder : " + scheduleModel.reminders[index].title);
        _showNotificationWithDefaultSound(index);
      } else {
        log.i(
            "No reminder set since notifications for reminders is currently turned off");
      }
    }
    notifyListeners();
  }

  Future addReminderDialog() async {
    DialogResponse response = await dialogService.showCustomDialog(
      variant: DialogType.reminder,
      title: "Add Reminder",
      // description: "Enter the task you want to be reminded of: ",
      mainButtonTitle: 'Enter',
      barrierDismissible: true,
    );
    log.i("Reminder response: ${response?.data}");
    if (response != null) {
      scheduleModel.reminders.add(Reminder(
        title: response.data[0],
        time: response.data[1],
        status: false,
      ));
      if (remindersNotificationsOn) {
        log.i("Setting reminder : " +
            scheduleModel.reminders[scheduleModel.reminders.length - 1].title +
            " at time " +
            scheduleModel.reminders[scheduleModel.reminders.length - 1].time);
        _showNotificationWithDefaultSound(scheduleModel.reminders.length - 1);
      } else {
        log.i(
            "No reminder set since notifications for this is currently turned off");
      }
    }
    notifyListeners();
  }

  void deleteTodo(int index) {
    scheduleModel.todo.removeAt(index);
    notifyListeners();
  }

  Future editTodo(int index) async {
    DialogResponse response = await dialogService.showCustomDialog(
      variant: DialogType.todo,
      title: "Edit To Do",
      data: [
        scheduleModel.todo[index].title,
      ],
      mainButtonTitle: 'Enter',
      barrierDismissible: true,
    );
    log.i("To DO response: ${response?.data}");
    if (response != null) {
      scheduleModel.todo[index].title = response.data[0];
    }
    notifyListeners();
  }

  Future addTodo() async {
    DialogResponse response = await dialogService.showCustomDialog(
      variant: DialogType.todo,
      title: "Add To Do",
      mainButtonTitle: 'Enter',
      barrierDismissible: true,
    );
    log.i("To Do response: ${response?.data}");
    if (response != null)
      scheduleModel.todo.add(Todo(
        title: response.data[0],
        status: false,
      ));
    added = true;
    notifyListeners();
  }

  @override
  Future futureToRun() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("notifications_on") != null) {
      remindersNotificationsOn = prefs.getBool("notifications_on") &&
          prefs.getBool("reminders_notification");
    }
    notifyListeners();
    remindersNotificationsOn
        ? log.i("Notifications for reminders are currently on")
        : log.i("Notifications for reminders are currently off");
    setReminderOnPhone();
    List<Todo> todo = await _firestoreService.getPreviousToDo(
        uid, Timestamp.fromDate(selectedDate));
    if (!await _firestoreService.isDataPresent(uid, date, 'schedule')) {
      scheduleModel = new ScheduleModel(
          reminders: [],
          todo: todo,
          timestamp: Timestamp.fromDate(selectedDate));
    } else {
      scheduleModel = await _firestoreService.getScheduleData(uid, date);
      todo.forEach((allTodo) {
        bool isUniqueAdd = true;
        scheduleModel.todo.forEach((todo) {
          if (todo.title.compareTo(allTodo.title) == 0) {
            isUniqueAdd = false;
          }
        });
        if (isUniqueAdd) {
          scheduleModel.todo.add(allTodo);
        }
      });
    }
    dateCheck = scheduleModel.timestamp
            .toDate()
            .difference(DateTime.now())
            .inDays
            .abs() >=
        1;
    if (dateCheck)
      Fluttertoast.showToast(
          msg: "You cannot edit Todo and reminder once the day has passed",
          backgroundColor: Colors.black,
          textColor: Colors.white);
    log.i("upp" +
        scheduleModel.timestamp
            .toDate()
            .difference(DateTime.now())
            .inDays
            .toString());
    notifyListeners();
  }
}
