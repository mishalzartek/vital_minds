import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:vitalminds/core/app/app.locator.dart';
import 'package:vitalminds/core/app/app.router.dart';
import 'package:vitalminds/core/app/logger.dart';
import 'package:vitalminds/core/services/authentication_service.dart';
import 'package:vitalminds/core/services/firestore_service.dart';
import 'package:vitalminds/views/splash/splash_view.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseAuth;

class EmailVerificationViewModel extends BaseViewModel
    implements Initialisable {
  Logger log;
  bool isEmailVerified = false;
  Timer timer;
  bool canResendEmail = false;

  NavigationService navigationService = locator<NavigationService>();
  AuthenticationService authenticationService =
      locator<AuthenticationService>();
  FirestoreService firestoreService = locator<FirestoreService>();

  final firebaseAuth.FirebaseAuth _firebaseAuth =
      firebaseAuth.FirebaseAuth.instance;

  Future checkEmailVerified() async {
    log.i("email verification check");
    _firebaseAuth.currentUser.reload();
    log.i(_firebaseAuth.currentUser.emailVerified.toString());
    if (authenticationService.isEmailVerified()) {
      log.i('email verified');
      timer.cancel();
      await navigationService.replaceWithTransition(SplashView(),
          transitionStyle: Transition.rightToLeft);
    }
  }

  void signOut() async {
    if (await authenticationService.signOut())
      navigationService.clearStackAndShow(Routes.loginViewRoute);
  }

  Future sendVerificationEmail() async {
    log.i('Verification email triggered');
    try {
      await authenticationService.sendVerificationEmail();
      canResendEmail = true;
      await Future.delayed(Duration(seconds: 5));
      canResendEmail = false;
    } catch (e) {
      log.i(e.toString());
      Fluttertoast.showToast(timeInSecForIosWeb: 2, msg: e.toString());
    }
  }

  @override
  void initialise() async {
    this.log = getLogger(this.runtimeType.toString());

    if (!authenticationService.isEmailVerified()) {
      sendVerificationEmail();

      timer = Timer.periodic(
        Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
