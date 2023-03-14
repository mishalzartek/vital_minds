import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:vitalminds/core/app/app.locator.dart';
import 'package:vitalminds/core/app/app.router.dart';
import 'package:vitalminds/core/app/logger.dart';
import 'package:vitalminds/core/services/authentication_service.dart';
import 'package:vitalminds/views/login/login_view.dart';

class RegistrationViewModel extends BaseViewModel {
  Logger log;
  // TextEditingController emailController = new TextEditingController();
  TextEditingController phNumberController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();

  // int loginSwitch = 0;
  // String switchText = "Use Phone Number";
  NavigationService navigationService = locator<NavigationService>();
  AuthenticationService authenticationService =
      locator<AuthenticationService>();

  RegistrationViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    setBusy(false);
  }

  void navigateToLogin() {
    // navigationService.navigateTo(Routes.loginViewRoute);
    navigationService.replaceWithTransition(LoginView(),
        transition: 'rightToLeft');
  }

  Future register() async {
    setBusy(true);
      if (nameController.text == "" || phNumberController.text == "") {
        setBusy(false);
        Fluttertoast.showToast(
            timeInSecForIosWeb: 2, msg: "Phone/Name field is empty.");
      } else {
        authenticationService
            .loginWithPhoneNumber(
          phoneNumber: "+91" + phNumberController.text,
          age: ageController.text,
          name: nameController.text,
        )
            .onError((error, stackTrace) {
          log.e(error.toString());
          setBusy(false);
          Future.delayed(
              Duration(milliseconds: 500),
              () => Fluttertoast.showToast(
                  timeInSecForIosWeb: 2, msg: error.toString()));
        }).then((_) => navigationService.navigateTo(Routes.otpViewRoute,
                arguments: OTPViewArguments(login: false)));
      }
  }
}
