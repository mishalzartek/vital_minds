import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:vitalminds/core/app/app.locator.dart';
import 'package:vitalminds/core/app/logger.dart';
import 'package:vitalminds/core/services/authentication_service.dart';
import 'package:vitalminds/views/details_page_tab_bar/details_page_tab_bar_view.dart';
import 'package:vitalminds/views/home/home_view.dart';

class DetailsPageTabBarViewModel extends BaseViewModel {
  Logger log;
  NavigationService navigationService = locator<NavigationService>();
  AuthenticationService authenticationService =
      locator<AuthenticationService>();

  DateTime selectedDate;
  DetailsPageTabBarViewModel(DateTime selectedDate) {
    this.log = getLogger(this.runtimeType.toString());
    this.selectedDate = selectedDate;
    log.i(selectedDate.day.toString());
  }

  void navigateToHome(int i) {
    navigationService.clearTillFirstAndShowView(HomeView(i));
  }

  void goToPrevDate(context) {
    selectedDate = selectedDate.subtract(Duration(days: 1));
    if (selectedDate.isAfter(DateTime.utc(DateTime.now().year, 1, 1))) {
      notifyListeners();
      navigationService.replaceWithTransition(
          DetailsPageTabBarView(selectedDate: selectedDate),
          transition: 'leftToRight');
    } else {
      selectedDate = selectedDate.add(Duration(days: 1));
      Fluttertoast.showToast(
          msg: "Invalid Date!", gravity: ToastGravity.BOTTOM);
    }
  }

  void goToNextDate(BuildContext context) {
    selectedDate = selectedDate.add(Duration(days: 1));
    if (selectedDate.isBefore(DateTime.now())) {
      notifyListeners();
      navigationService.replaceWithTransition(
          DetailsPageTabBarView(selectedDate: selectedDate,),
          transition: 'rightToLeft');
    } else {
      Fluttertoast.showToast(
          msg: "Invalid Date!", gravity: ToastGravity.BOTTOM);
      selectedDate = selectedDate.subtract(Duration(days: 1));
    }
  }
}
