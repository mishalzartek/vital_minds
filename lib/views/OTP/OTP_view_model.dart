import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:vitalminds/core/app/app.locator.dart';
import 'package:vitalminds/core/app/logger.dart';
import 'package:vitalminds/core/services/authentication_service.dart';

class OTPViewModel extends BaseViewModel {
  Logger log;
  TextEditingController otpController = new TextEditingController();
  AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  OTPViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  Future verify(bool login, bool registration) async {
    setBusy(true);
    await _authenticationService.signInWithOTP(otpCode: otpController.text,login: login, registration: registration);
    setBusy(false);
  }
}
