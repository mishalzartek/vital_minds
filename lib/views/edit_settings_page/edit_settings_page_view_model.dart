import 'dart:developer';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vitalminds/core/models/user_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:vitalminds/core/app/app.locator.dart';
import 'package:vitalminds/core/services/authentication_service.dart';
import 'package:vitalminds/core/services/background_music_service.dart';
import 'package:vitalminds/core/services/firestore_service.dart';
import 'package:vitalminds/views/settings_page/settings_page_view.dart';
import 'package:vitalminds/widgets/dumb_widgets/YoutubeScreen/YT_Screen.dart';

class EditSettingsPageViewModel extends FutureViewModel
    implements Initialisable {
  NavigationService navigationService = locator<NavigationService>();
  AuthenticationService authenticationService =
      locator<AuthenticationService>();
  FirestoreService _firestoreService = locator<FirestoreService>();
  BackgroundMusicService _backgroundMusicService =
      locator<BackgroundMusicService>();
  List titles = ["Habits", "Reminders", "Journal"];
  List checkValues = [true, true, false];
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  String email = " ";
  String phno = "-";
  String id = " ";
  bool switchValue = true;
  bool applock = false;
  SharedPreferences prefs;
  void passwordDialog(context, width, height) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Color.fromARGB(200, 255, 255, 255),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            title: Center(child: Text('Update your Password')),
            titleTextStyle: TextStyle(
              fontFamily: 'Roboto',
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            content: Container(
              width: width * 0.6,
              height: height * 0.1,
              child: TextFormField(
                keyboardType: TextInputType.text,
                decoration:
                    InputDecoration(labelText: "Enter your new password"),
                controller: password,
              ),
            ),
            titlePadding: const EdgeInsets.all(20.0),
            contentPadding: const EdgeInsets.all(15.0),
            actions: [
              new TextButton(
                child: new Text(
                  "Cancel",
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new TextButton(
                child: new Text("OK"),
                onPressed: () {
                  if (password.text.isNotEmpty &&
                      regExp.hasMatch(password.text)) {
                    notifyListeners();
                    authenticationService
                        .changePassword(
                            authenticationService.user, password.text)
                        .then((v) => Navigator.of(context).pop());
                  } else {
                    Fluttertoast.showToast(
                        msg:
                            "should contain at least one upper case, lower case , one digit ,  one special character and min. length of 8",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                },
              ),
            ],
          );
        });
  }

  void inputDialog(context, width, height) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Color.fromARGB(200, 255, 255, 255),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            title: Center(child: Text('Update your Phone number')),
            titleTextStyle: TextStyle(
              fontFamily: 'Roboto',
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            content: Container(
              width: width * 0.6,
              height: height * 0.1,
              child: TextFormField(
                validator: (text) {
                  if (!(text.length > 10) && text.isNotEmpty) {
                    return 'Phone number should contain 10 digits';
                  }
                  return null;
                },
                keyboardType: TextInputType.phone,
                decoration:
                    InputDecoration(labelText: "Enter your phone number"),
                controller: phone,
              ),
            ),
            titlePadding: const EdgeInsets.all(20.0),
            contentPadding: const EdgeInsets.all(15.0),
            actions: [
              new TextButton(
                child: new Text(
                  "Cancel",
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new TextButton(
                child: new Text("OK"),
                onPressed: () {
                  if ((phone.text.length == 10) && phone.text.isNotEmpty) {
                    phno = phone.text;
                    notifyListeners();
                    changePhoneNumber(phone.text)
                        .whenComplete(() => Navigator.of(context).pop());
                  } else {
                    Fluttertoast.showToast(
                        msg: "Phone number should contain 10 digits",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                },
              ),
            ],
          );
        });
  }

  Future getProfileData(String uid) async {
    UserModel user = await _firestoreService.getUser(uid);
    email = user.email ?? " ";
    phno = email == " "
        ? authenticationService.user.phoneNumber
        : await _firestoreService.getPhone(uid) ?? " ";
    id = authenticationService.user.uid;
    notifyListeners();
  }

  void navigateToProfilePage() {
    navigationService.navigateWithTransition(SettingsPageView(),
        transition: 'leftToRight');
  }

  void changeSwitchValue(bool value) {
    switchValue = value;
    prefs.setBool("enableBgMusic", value);
    log(value.toString());
    if (value)
      _backgroundMusicService.startBgMusic();
    else
      _backgroundMusicService.stopBgMusic();
      globalAssetsAudioPlayer.stop();
    notifyListeners();
  }

  void changeAppLock(bool value) {
    applock = value;
    prefs.setBool("enableAppLock", value);
    log(value.toString());
    notifyListeners();
  }

  Future changePhoneNumber(String phno) async {
    _firestoreService.addPhoneNumber(id, phno);
  }

  void changeCheckValue(bool value, int i) {
    checkValues[i] = value;
    notifyListeners();
  }

  @override
  Future futureToRun() async {
    prefs = await SharedPreferences.getInstance();
    switchValue = prefs.getBool("enableBgMusic") ?? true;
    applock = prefs.getBool("enableAppLock") ?? false;
    await getProfileData(authenticationService.user.uid);
  }
}
