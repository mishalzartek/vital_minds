import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:vitalminds/core/app/app.locator.dart';
import 'package:vitalminds/core/app/app.router.dart';
import 'package:vitalminds/core/app/logger.dart';
import 'package:vitalminds/core/services/authentication_service.dart';
import 'package:vitalminds/core/services/firestore_service.dart';
import 'package:vitalminds/views/registration/registration_view.dart';
import 'package:vitalminds/views/reset_password/reset_password_view.dart';

class LoginViewModel extends BaseViewModel {
  Logger log;
  // TextEditingController emailController = new TextEditingController();
  TextEditingController phNumberController = new TextEditingController();
  // TextEditingController passwordController = new TextEditingController();
  FocusNode email = new FocusNode();
  List<double> op = [0.25, 0.25];
  FocusNode password = new FocusNode();
  bool enabled = true;

  // int loginSwitch = 0;
  List<bool> flags = [false, false];
  // String switchText = "Use Phone Number";
  NavigationService navigationService = locator<NavigationService>();
  AuthenticationService authenticationService =
      locator<AuthenticationService>();
  FirestoreService firestoreService = locator<FirestoreService>();

  LoginViewModel() {
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
    navigationService.navigateToView(ResetView());
  }

  void navigateToRegister() {
    // navigationService.navigateTo(Routes.registrationViewRoute);
    navigationService.replaceWithTransition(RegistrationView(),
        transition: 'rightToLeft');
  }

  enabledTextField() {
    enabled = phNumberController.text.characters.length > 11 ? false : true;
    notifyListeners();
  }

  String validateMobile(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }

  Future login() async {
    setBusy(true);
    var mobileNumberError = validateMobile(phNumberController.text);
    log.e(mobileNumberError);
    if (mobileNumberError == null) {
      await authenticationService
          .loginWithPhoneNumber(phoneNumber: '+91' + phNumberController.text)
          .onError((error, stackTrace) {
        log.e(error.toString());
        setBusy(false);
        Future.delayed(
            Duration(milliseconds: 500),
            () => Fluttertoast.showToast(
                timeInSecForIosWeb: 2, msg: error.toString()));
      }).then((_) {
        navigationService.navigateTo(Routes.otpViewRoute,
            arguments: OTPViewArguments(login: true, registration: false));
      });
    } else {
      setBusy(false);
      Fluttertoast.showToast(timeInSecForIosWeb: 2, msg: mobileNumberError);
    }
    Timer.periodic(Duration(seconds: 1), (timer) {
      setBusy(false);
      timer.cancel();
    });
  }
}
