import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:vitalminds/core/app/app.locator.dart';
import 'package:vitalminds/core/app/logger.dart';
import 'package:vitalminds/core/services/authentication_service.dart';
import 'package:vitalminds/core/services/firestore_service.dart';
import 'package:vitalminds/views/home/home_view.dart';
import 'package:vitalminds/widgets/smart_widgets/worksheets_details/worksheets_details_widget.dart';

class CbtPersonalViewModel extends BaseViewModel implements Initialisable {
  Logger log;
  double radius = 5;
  BuildContext context;
  NavigationService navigationService = locator<NavigationService>();
  AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  FirestoreService _firestoreService = locator<FirestoreService>();
  Map<String, dynamic> cbt = {};
  List<String> cbtTitle = [];
  List cbtValue = [];
  List  worksheets = [];
  List<Map> completedWorksheets = [];
  ReactiveValue<DateTime> selectedDate =
      ReactiveValue<DateTime>(DateTime.now());
  CbtPersonalViewModel(DateTime selectedDate, BuildContext context) {
    this.log = getLogger(this.runtimeType.toString());
    this.selectedDate.value = selectedDate;
    log.i("selected date " + selectedDate.toString());
    this.context = context;
  }

  Future<void> init() async {
    cbt = await _firestoreService.getCBTData(
            _authenticationService.user.uid, selectedDate.value) ??
        {};
    worksheets = await _firestoreService.getAllWorksheetsData(
            _authenticationService.user.uid, selectedDate.value) ??
        [];
    completedWorksheets = await _firestoreService.getWorkSheetData(
            _authenticationService.user.uid, selectedDate.value) ??
        [];
    log.i("completed worksheets" + completedWorksheets.toString());
   // log.i("all worksheets" + worksheets[0].data().runtimeType.toString());
    notifyListeners();
    cbt.forEach((key, value) {
      cbtTitle.add(key);
      cbtValue.add(value);
    });
  }

  void changeRadius(bool v) {
    if (v) {
      radius = 10;
      notifyListeners();
    }
  }

  void navigateToDetailsPage(String worksheetName) {
    String categoryTitle;
    String mainTitle;
    if (worksheetName == "4A'sofstress") {
      mainTitle = "4 A's of stress";
      categoryTitle = "Stress relief";
    } else if (worksheetName == "TurningStressIntoAction") {
      mainTitle = "Turning Stress Into Action";
      categoryTitle = "Stress relief";
    } else if (worksheetName == "Stopworryingaboutthefuture") {
      mainTitle = "Stop worrying about the future";
      categoryTitle = "Stress relief";
    } else if (worksheetName == "ReframingourSHOULDstatements") {
      mainTitle = "ReframingourSHOULDstatements";
      categoryTitle = "Stress relief";
    } else if (worksheetName == "What'sstoppingyoufromtakingabreak") {
      mainTitle = "What's stopping you from taking a break";
      categoryTitle = "Stress relief";
    } else if (worksheetName == "Livingalifeofmeaningandpurpose") {
      mainTitle = "Living a life of meaning and purpose";
      categoryTitle = "Stress relief";
    } else if (worksheetName == "Takingcharge") {
      mainTitle = "Taking charge";
      categoryTitle = "Stress relief";
    } else if (worksheetName == "QuestioningOurAssumptions") {
      mainTitle = "Questioning Our Assumptions";
      categoryTitle = "Stress relief";
    } else if (worksheetName == "TappingintoourResources") {
      mainTitle = "Tapping into our Resources";
      categoryTitle = "Stress relief";
    } else if (worksheetName == "Eisenhower'sTimeManagementMatrix") {
      mainTitle = "Eisenhower's Time Management Matrix";
      categoryTitle = "Increase your productivity";
    } else if (worksheetName == "Ruleofthree") {
      mainTitle = "Rule of three";
      categoryTitle = "Increase your productivity";
    } else if (worksheetName == "Tinychangeswithbigbenefits") {
      mainTitle = "Tiny changes with big benefits";
      categoryTitle = "Increase your productivity";
    } else if (worksheetName == "Habits") {
      mainTitle = "Habits";
      categoryTitle = "Increase your productivity";
    } else if (worksheetName == "LessisMore") {
      mainTitle = "Less is More";
      categoryTitle = "Simplifying Life";
    } else if (worksheetName == "ABCDEModel") {
      mainTitle = "ABCDE Model";
      categoryTitle = "Reflection";
    } else if (worksheetName == "ThoughtRecord") {
      mainTitle = "ThoughtRecord";
      categoryTitle = "Reflection";
    } else if (worksheetName == "Developingtolerancetowardsanxiety") {
      mainTitle = "Developing tolerance towards anxiety";
      categoryTitle = "Reduce Anxiety";
    } else if (worksheetName == "SocialActivation") {
      mainTitle = "Social Activation";
      categoryTitle = "Reduce Anxiety";
    } else if (worksheetName == "BehavioralActivation") {
      mainTitle = "Behavioral Activation";
      categoryTitle = "Fight Depression";
    } else if (worksheetName == "Positivepersonality") {
      mainTitle = "Positive personality";
      categoryTitle = "Fight Depression";
    }
    print("navigating to $categoryTitle, $mainTitle");
    navigationService.navigateToView(
        WorksheetsDetailsWidget(categoryTitle, mainTitle, selectedDate.value, true));
  }

  String getWorksheetNameFromDoc(String documentName) {
    String mainTitle;
    if (documentName == "4A'sofstress")
      mainTitle = "4 A's of stress";
    else if (documentName == "TurningStressIntoAction")
      mainTitle = "Turning Stress Into Action";
    else if (documentName == "Stopworryingaboutthefuture")
      mainTitle = "Stop worrying about the future";
    else if (documentName == "ReframingourSHOULDstatements")
      mainTitle = "Reframing our SHOULD statements";
    else if (documentName == "What'sstoppingyoufromtakingabreak")
      mainTitle = "What's stopping you from taking a break";
    else if (documentName == "Livingalifeofmeaningandpurpose")
      mainTitle = "Living a life of meaning and purpose";
    else if (documentName == "Takingcharge")
      mainTitle = "Taking charge";
    else if (documentName == "QuestioningOurAssumptions")
      mainTitle = "Questioning Our Assumptions";
    else if (documentName == "TappingintoourResources")
      mainTitle = "Tapping into our Resources";
    else if (documentName == "Eisenhower'sTimeManagementMatrix")
      mainTitle = "Eisenhower's Time Management Matrix";
    else if (documentName == "Ruleofthree")
      mainTitle = "Rule of three";
    else if (documentName == "Tinychangeswithbigbenefits")
      mainTitle = "Tiny changes with big benefits";
    else if (documentName == "Habits")
      mainTitle = "Habits";
    else if (documentName == "LessisMore")
      mainTitle = "Less is More";
    else if (documentName == "ABCDEModel")
      mainTitle = "ABCDE Model";
    else if (documentName == "ThoughtRecord")
      mainTitle = "ThoughtRecord";
    else if (documentName == "Developingtolerancetowardsanxiety")
      mainTitle = "Developing tolerance towards anxiety";
    else if (documentName == "SocialActivation")
      mainTitle = "Social Activation";
    else if (documentName == "BehavioralActivation")
      mainTitle = "Behavioral Activation";
    else if (documentName == "Positivepersonality")
      mainTitle = "Positive personality";
    return mainTitle;
  }

  void gotToWorksheets(int i) {
    navigationService.clearTillFirstAndShowView(HomeView(0, i));
  }

  @override
  void initialise() {
    init();
  }
}
