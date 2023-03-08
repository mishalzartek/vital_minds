import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:vitalminds/core/app/app.locator.dart';
import 'package:vitalminds/core/app/app.router.dart';
import 'package:vitalminds/core/app/logger.dart';
import 'package:vitalminds/core/services/authentication_service.dart';

class ResetViewModel extends BaseViewModel {
  AuthenticationService _authenticationService =
  locator<AuthenticationService>();
  Logger log;
  TextEditingController passwordController = new TextEditingController();
  FocusNode email = new FocusNode();
  List<double> op = [0.25, 0.25];

  List<bool> flags = [false, false];
  NavigationService navigationService = locator<NavigationService>();
  AuthenticationService authenticationService =
  locator<AuthenticationService>();

  ResetViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    setBusy(false);
  }
  changeOpacity(int i, TextEditingController t) {
    if (t.text.isNotEmpty) {
      op[i] = 0.5;
      flags[i] = true;
    } else
      op[i] = 0.25;
    notifyListeners();
  }

  void forgotPassword() async {
    if (passwordController.text != null)
      try {
        await _authenticationService.forgotPassword(passwordController.text);
        Fluttertoast.showToast(
            msg: "Please check your email and reset your password");
      } on FirebaseException catch (e) {
        log.e(e.message);
        Fluttertoast.showToast(msg: e.message);
      }
  }


  void navigateToRegister() {
    navigationService.navigateTo(Routes.registrationViewRoute);
  }
}
