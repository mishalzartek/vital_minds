import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:vitalminds/core/app/app.locator.dart';
import 'package:vitalminds/core/app/logger.dart';
import 'package:vitalminds/core/services/authentication_service.dart';
import 'package:vitalminds/core/services/firestore_service.dart';
import 'package:vitalminds/widgets/smart_widgets/worksheets_details/worksheets_details_widget.dart';

class WorksheetsWidgetViewModel extends FutureViewModel {
  Logger log;
  DateTime selectedDay = DateTime.now();
  NavigationService navigationService = locator<NavigationService>();
  AuthenticationService authenticationService =
      locator<AuthenticationService>();
  FirestoreService firestoreService = locator<FirestoreService>();
  List<Map<String, dynamic>> stressWorksheets = [
    {"title": "4 A's of stress", "time": "6 mins"},
    {"title": "Turning Stress Into Action", "time": "4 mins"},
    {"title": "Stop worrying about the future", "time": "5 mins"},
    {"title": "Reframing our SHOULD statements", "time": "10 mins"},
    {"title": "What's stopping you from taking a break", "time": "8 mins"},
    {"title": "Living a life of meaning and purpose", "time": "6 mins"},
    {"title": "Taking charge", "time": "5 mins"},
    {"title": "Questioning Our Assumptions", "time": "12 mins"},
    {"title": "Tapping into our Resources", "time": "7 mins"},
  ];
  List<Map<String, dynamic>> productivityorksheets = [
    {"title": "Eisenhower's Time Management Matrix", "time": "8 mins"},
    {"title": "Rule of three", "time": "5 mins"},
    {"title": "Turning Stress Into Action", "time": "4 mins"},
    {"title": "Tiny changes with big benefits", "time": "3 mins"},
    {"title": "Habits", "time": "4 mins"}
  ];
  List<Map<String, dynamic>> simplifyingLife = [
    {"title": "Tiny changes with big benefits", "time": "3 mins"},
    {"title": "Habits", "time": "4 mins"},
    {"title": "Living a life of meaning and purpose", "time": "6 mins"},
    {"title": "Less is More", "time": "8 mins"},
  ];
  List<Map<String, dynamic>> reflection = [
    {"title": "ABCDE Model", "time": "4 mins"},
    {"title": "Thought Record", "time": "10 mins"},
  ];
  List<Map<String, dynamic>> anxiety = [
    {"title": "Developing tolerance towards anxiety", "time": "4 mins"},
    {"title": "Social Activation", "time": "3 mins"},
    {"title": "Questioning Our Assumptions", "time": "12 mins"},
    {"title": "Tapping into our Resources", "time": "7 mins"},
  ];
  List<Map<String, dynamic>> depression = [
    {"title": "Social Activation", "time": "3 mins"},
    {"title": "Behavioral Activation", "time": "2 mins"},
    {"title": "Positive personality", "time": "2 mins"},
  ];
  List completedWorksheetsList = [];
  void navigateToDetailsPage(
    String categoryTitle,
    String mainTitle,
    BuildContext context,
  ) {
    print("navigating to $categoryTitle, $mainTitle");
    log.i(selectedDay.toString());
    navigationService.navigateToView(
      WorksheetsDetailsWidget(categoryTitle, mainTitle, selectedDay, false),
    );
  }

  Future getData() async {
    log.i("Future for worksheets main page called");
    QuerySnapshot completedWorksheets = await firestoreService.getWorksheetData(
        authenticationService.user.uid, selectedDay);
    for (var worksheet in completedWorksheets.docs) {
      completedWorksheetsList.add(worksheet.id);
    }
    return completedWorksheetsList;
  }

  Future dispose() async {
    log.i("Dispose called");
    super.dispose();
  }

  WorksheetsWidgetViewModel(DateTime date) {
    log = getLogger(this.runtimeType.toString());
    selectedDay = date;
  }

  @override
  Future futureToRun() async {
    completedWorksheetsList = await getData();
    log.i("Completed Worksheets are : " + completedWorksheetsList.toString());
  }
}
