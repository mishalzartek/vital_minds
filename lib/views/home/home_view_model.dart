import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:vitalminds/core/app/app.locator.dart';
import 'package:vitalminds/core/app/logger.dart';
import 'package:vitalminds/core/services/authentication_service.dart';
import 'package:vitalminds/core/services/firestore_service.dart';
import 'package:vitalminds/views/settings_page/settings_page_view.dart';
import 'package:vitalminds/widgets/dumb_widgets/Themes.dart';

class HomeViewModel extends IndexTrackingViewModel implements Initialisable {
  Logger log;
  SharedPreferences prefs;
  NavigationService navigationService = locator<NavigationService>();
  AuthenticationService authenticationService =
      locator<AuthenticationService>();
  FirestoreService firestoreService = locator<FirestoreService>();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  String name;
  String image;
  void navigateToSettingsPage() {
    navigationService.navigateWithTransition(SettingsPageView(), transition: 'rightToLeft');
  }

  Future<Color> getColor() async {
    prefs = await SharedPreferences.getInstance();
    Color color = prefs.get("cacheTheme") != null
        ? Color(prefs.get("cacheTheme"))
        : Color(0xff5a5ed0).withOpacity(0.55);
    Themes.color = prefs.get("cacheColor") != null
        ? Color(prefs.get("cacheColor"))
        : Color(0xff5a5ed0);
    notifyListeners();
    return color;
  }

  Future checkNet() async{
    try {
      final result = await InternetAddress.lookup('google.com').timeout(Duration(seconds: 5));
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
      return true;
    } on Exception catch (_) {
      Fluttertoast.showToast(msg: "No internet found",gravity: ToastGravity.SNACKBAR);
      return false;
    }
  }
  getTheme(Color color) async {
    Themes.bgMode = ColorFilter.mode(color, BlendMode.overlay) ??
        ColorFilter.mode(Colors.pinkAccent, BlendMode.overlay);
    notifyListeners();
    log.d(Themes.bgMode.toString());
  }

  Future getImage() async {
    prefs = await SharedPreferences.getInstance();
    var check = await checkNet();
    if(check) {
      if (prefs.getString("image") == null) {
        image =
        await firestoreService.downloadURL(authenticationService.user.uid, 1);
        image == null ? log.i("No profile pic") : prefs.setString(
            "image", image);
      }
      image = prefs.getString("image");
      notifyListeners();
    }
    else{
      image =null;
    }
  }

  Future setHabitsAndJournalsNotifications() async {
    bool habitsNotifications = true;
    bool journalNotifications = true;
    prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("notifications_on") != null) {
      habitsNotifications = prefs.getBool("notifications_on") &&
          prefs.getBool("habits_notification");
      journalNotifications = prefs.getBool("notifications_on") &&
          prefs.getBool("journal_notification");
    }
    if (habitsNotifications) {
      _setHabitsNotification();
      log.i("Scheduled Habits Notification for 2 PM");
    }
    if (journalNotifications) {
      _setJournalNotification();
      log.i("Scheduled Journals Notification for 8 PM");
    }
  }

  Future onSelectNotification(String payload) async {}

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {}

  Future _setJournalNotification() async {
    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      'You have not made any journal entries yet, head over to the app to record your mood and feelings',
      htmlFormatBigText: true,
      contentTitle: 'Update Journal',
      htmlFormatContentTitle: true,
      summaryText: '',
      htmlFormatSummaryText: true,
    );
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails('3',
        'journals', channelDescription: 'Notification to remind the user to make journal entry',
        importance: Importance.max,
        priority: Priority.high,
        styleInformation: bigTextStyleInformation);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    var time = Time(20, 00, 0);
    // ignore: deprecated_member_use
    await flutterLocalNotificationsPlugin.showDailyAtTime(
        3,
        'Update Journal',
        'You have not made any journal entries yet, head over to the app to record your mood and feelings',
        time,
        platformChannelSpecifics);
  }

  Future _setHabitsNotification() async {
    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      'You have not tracked your habits today, head over to the app to create habits and to track them',
      htmlFormatBigText: true,
      contentTitle: 'Track your Habits',
      htmlFormatContentTitle: true,
      summaryText: '',
      htmlFormatSummaryText: true,
    );
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails('1',
        'habits', channelDescription: 'Notification to remind the user to track his/her habits',
        importance: Importance.max,
        priority: Priority.high,
        styleInformation: bigTextStyleInformation);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    var time = Time(14, 00, 0);
    // ignore: deprecated_member_use
    await flutterLocalNotificationsPlugin.showDailyAtTime(
        1,
        'Track your Habits',
        'You have not tracked your habits today, head over to the app to create habits and to track them',
        time,
        platformChannelSpecifics);
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
    await setHabitsAndJournalsNotifications();
  }

  @override
  void initialise() async {
    this.log = getLogger(this.runtimeType.toString());
    await setReminderOnPhone();
    getColor().then((value) => getTheme(value));
    getImage();
    if (authenticationService.user == null ||
        authenticationService.user.uid == null) {
      name = " ";
    } else {
      name??="User";
      name = authenticationService.user.displayName??"".split(" ")[0];
      //name = name = authenticationService.currentUser.name.split(" ")[0];
    }
    // prefs = await SharedPreferences.getInstance();
  }
}
