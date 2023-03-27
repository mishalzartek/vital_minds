import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked_themes/stacked_themes.dart';
import 'package:vitalminds/core/app/app.locator.dart';
import 'package:vitalminds/core/services/background_music_service.dart';
import 'package:vitalminds/views/ui/setup_dialog_ui.dart';
import 'package:vitalminds/widgets/dumb_widgets/Themes.dart';

import 'core/app/app.router.dart';
import 'package:flutter/services.dart';
ImageProvider myImage;
void main() async {
  runZonedGuarded<Future<void>>(() async {final binding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  binding.addPostFrameCallback((_)
  async{
    BuildContext context = binding.renderViewElement;
    if(context != null)
      {
        myImage = AssetImage('assets/images/frosted2.png');
        precacheImage(myImage, context);
      }
  });
  await ThemeManager.initialise();
  setupLocator();
  setupDialogUi();


  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
        FirebaseCrashlytics.instance.recordFlutterError;
    runApp(MyApp());
  });
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
  
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final BackgroundMusicService backgroundMusicService =
      locator<BackgroundMusicService>();
  SharedPreferences prefs;
  bool playBgMusic;

  Future getPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  void initState() {
    super.initState();
    //checkNet();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    if (playBgMusic) backgroundMusicService.disposeBgMusic();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    // These are the callbacks
    switch (state) {
      case AppLifecycleState.resumed:
        // widget is resumed
        playBgMusic = prefs.getBool("enableBgMusic") ?? true;
        if (playBgMusic) backgroundMusicService.playBgMusic();
        break;
      case AppLifecycleState.inactive:
        // widget is inactive
        playBgMusic = prefs.getBool("enableBgMusic") ?? true;
        if (playBgMusic) backgroundMusicService.pauseBgMusic();
        break;
      case AppLifecycleState.paused:
        // widget is paused
        playBgMusic = prefs.getBool("enableBgMusic") ?? true;
        if (playBgMusic) backgroundMusicService.pauseBgMusic();
        break;
      default:
        // widget is detached
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getPref(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          playBgMusic = prefs.getBool("enableBgMusic") ?? true;
          if (playBgMusic == true) {
            backgroundMusicService.startBgMusic();
          }
          return ThemeBuilder(
            themes: Themes().getThemes(),
            builder: (context, regularTheme, darkTheme, themeMode) =>
                MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: regularTheme,
              themeMode: themeMode,
              darkTheme: darkTheme,
              title: 'My Vital Mind',
              navigatorKey: StackedService.navigatorKey,
              onGenerateRoute: StackedRouter().onGenerateRoute,
            ),
          );
        } else
          return Container();
      },
    );
  }
}