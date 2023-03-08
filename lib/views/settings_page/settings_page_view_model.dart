import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vitalminds/core/app/app.locator.dart';
import 'package:vitalminds/core/app/app.router.dart';
import 'package:vitalminds/core/app/logger.dart';
import 'package:vitalminds/core/services/authentication_service.dart';
import 'package:vitalminds/core/services/firestore_service.dart';
import 'package:vitalminds/views/Notifications_page/notifications_view.dart';
import 'package:vitalminds/views/about_us_Page/about_us_view.dart';
import 'package:vitalminds/views/edit_settings_page/edit_settings_page_view.dart';
import 'package:vitalminds/views/home/home_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vitalminds/views/settings_page/settings_page_view.dart';
import 'package:vitalminds/widgets/dumb_widgets/Help_and_support/Help_n_support_page.dart';
import 'package:vitalminds/widgets/dumb_widgets/Themes.dart';

class SettingsPageViewModel extends BaseViewModel implements Initialisable {
  Logger log;
  bool switchValue = false;
  File image;
  bool imageChange = false;
  final picker = ImagePicker();
  SharedPreferences prefs;
  BuildContext context;
  List titles = [
    "Notifications",
    "Settings",
    "About",
    "Feedback",
    "Invite",
    "Help and Support"
  ];
  List descriptions = [
    "Set up notifications",
    "Change Password and others",
    "Privacy Policy, Version and Message",
    "Provide your feedback about the app",
    "Send invitations to your friends to use VitalMinds",
    "Terms and Conditions, FAQs"
  ];

  List<Color> currentColors = [Colors.limeAccent, Colors.green];
  NavigationService navigationService = locator<NavigationService>();
  FirestoreService firestoreService = locator<FirestoreService>();
  AuthenticationService authenticationService =
      locator<AuthenticationService>();
  String name;
  Future<void> themeChange(Color col) async {
    await Themes().changeColors(col);
    await Themes().changeTheme(col);
    NavigationService navigationService = locator<NavigationService>();
    navigationService.replaceWithTransition(SettingsPageView(),
        transition: 'fade');
  }

  void changeValue(value) {
    switchValue = value;
    notifyListeners();
  }

  void navigate(int i) {
    switch (i) {
      case 0:
        navigationService.navigateWithTransition(NotificationsPageView(),
            transition: 'rightToLeft');
        break;
      case 1:
        navigationService.navigateWithTransition(EditSettingsPageView(),
            transition: 'rightToLeft');
        break;
      case 2:
        navigationService.navigateWithTransition(AboutUsPageView(),
            transition: 'rightToLeft');
        break;
      case 3:
        launch("mailto:myvitalmind3@gmail.com?subject=Vitalminds Feedback");
        break;
      case 4:
        //TODO: implement invite
        break;
      case 5:
        navigationService.navigateWithTransition(HelpandSupportWidget(),
            transition: 'rightToLeft');
        break;
    }
  }

  _imgFromCamera() async {
    if (await Permission.storage.request().isGranted) {
      try {
        final pickedFile = await picker.pickImage(
            source: ImageSource.camera, imageQuality: 75);
        if (pickedFile != null) {
          prefs = await SharedPreferences.getInstance();
          image = File(pickedFile.path);
          notifyListeners();
          deleteProfilePic();
          firestoreService.uploadProfilePic(
              authenticationService.user.uid, image);
          imageChange = true;
          await prefs.remove("image");
        } else {
          print('No image selected.');
        }
        notifyListeners();
      } catch (e) {
        print(e.toString());
      }
    }
  }

  _imgFromGallery() async {
    if (await Permission.storage.request().isGranted) {
      try {
        final pickedFile = await picker.pickImage(
            source: ImageSource.gallery, imageQuality: 75);
        if (pickedFile != null) {
          prefs = await SharedPreferences.getInstance();
          image = File(pickedFile.path);
          notifyListeners();
          deleteProfilePic();
          firestoreService.uploadProfilePic(
              authenticationService.user.uid, image);
          imageChange = true;
          await prefs.remove("image");
        } else {
          print('No image selected.');
        }
        notifyListeners();
      } catch (e) {
        print(e.toString());
      }
    }
  }

  Future getImage() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    File temp = File('${appDocDir.path}/download-logo.png');
    if (await temp.exists()) {
      image = temp;
      notifyListeners();
    } else {
      image =
          await firestoreService.downloadURL(authenticationService.user.uid);
      notifyListeners();
    }
  }

  void showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void navigateToHomePage() {
    navigationService.navigateToView(HomeView());
  }

  SettingsPageViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
  void deleteProfilePic() async {
    var directory = await getApplicationDocumentsDirectory();
    String path = directory.path;
    File del = File("$path/download-logo.png");
    if (del.existsSync()) await del.delete();
  }

  void signOut() async {
    prefs = await SharedPreferences.getInstance();
    await prefs.remove("cacheColor");
    await prefs.remove("cacheTheme");
    deleteProfilePic();
    if (await authenticationService.signOut())
      navigationService.clearStackAndShow(Routes.loginViewRoute);
  }

  @override
  void initialise() async {
    getImage();
    if (authenticationService.user == null ||
        authenticationService.user.uid == null) {
      name = " ";
    } else {
      name = authenticationService.user.displayName.split(" ")[0];
      //name = name = authenticationService.currentUser.name.split(" ")[0];
    }
  }
}
