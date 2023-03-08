import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:vitalminds/core/app/app.locator.dart';
import 'package:vitalminds/core/app/logger.dart';
import 'package:vitalminds/core/models/habits_model.dart';
import 'package:vitalminds/core/services/authentication_service.dart';
import 'package:vitalminds/core/services/firestore_service.dart';
import 'package:vitalminds/views/details_page_tab_bar/details_page_tab_bar_view.dart';
import 'package:vitalminds/views/ui/setup_dialog_ui.dart';

class EditHabitsPageViewModel extends FutureViewModel {
  Logger log;
  DateTime date;
  DialogService dialogService = locator<DialogService>();
  FirestoreService firestoreService = locator<FirestoreService>();
  AuthenticationService authenticationService =
      locator<AuthenticationService>();
  NavigationService navigationService = locator<NavigationService>();
  // String todaysDay = DateFormat('EEEE').format(DateTime.now());
  HabitsModel habitsModel;
  // List<Map<String, dynamic>> habits = [
  //   {
  //     "title": "Workout for 20 mins",
  //     "Monday": true,
  //     "Tuesday": true,
  //     "Wednesday": true,
  //     "Thursday": true,
  //     "Friday": true,
  //     "Saturday": true,
  //     "Sunday": true,
  //     "expanded": false
  //   },
  //   {
  //     'title': 'Reduce Smoking',
  //     'Monday': true,
  //     'Tuesday': true,
  //     'Wednesday': true,
  //     'Thursday': true,
  //     'Friday': true,
  //     'Saturday': true,
  //     'Sunday': true,
  //     'expanded': false
  //   },
  //   {
  //     'title': 'Drink 8 glasses of water',
  //     'Monday': true,
  //     'Tuesday': true,
  //     'Wednesday': true,
  //     'Thursday': true,
  //     'Friday': true,
  //     'Saturday': true,
  //     'Sunday': true,
  //     'expanded': false
  //   },
  //   {
  //     'title': 'Go to bed by 10',
  //     'Monday': true,
  //     'Tuesday': true,
  //     'Wednesday': true,
  //     'Thursday': false,
  //     'Friday': true,
  //     'Saturday': true,
  //     'Sunday': true,
  //     'expanded': false
  //   },
  //   {
  //     'title': 'Wake up by 10',
  //     'Monday': true,
  //     'Tuesday': true,
  //     'Wednesday': true,
  //     'Thursday': true,
  //     'Friday': false,
  //     'Saturday': false,
  //     'Sunday': false,
  //     'expanded': false
  //   }
  // ];
  // List<Map<String, dynamic>> returnedList = [];
  // void changeExpandedState(int index) {
  //   // if (habitsList[index].values.last) {
  //   //   habitsList[index].values.toList().last = false;
  //   //   notifyListeners();
  //   //   return habitsList;
  //   // } else {
  //   //   habitsList[index].values.toList().last = true;
  //   //   notifyListeners();
  //   //   return habitsList;
  //   // }
  //   habitsModel.habits[index].expanded = !habitsModel.habits[index].expanded;
  //   notifyListeners();
  // }

  void changeStatus(int index) {
    habitsModel.habits[index].status = !habitsModel.habits[index].status;
    notifyListeners();
  }

  void deleteHabit(int index) {
    habitsModel.habits.removeAt(index);
    notifyListeners();
  }

  Future addHabit() async {
    DialogResponse response = await dialogService.showCustomDialog(
      variant: DialogType.habit,
      title: "Add Habit",
      barrierDismissible: true,
      // description: "Enter the task you want to be reminded of: ",
      mainButtonTitle: 'Enter',
    );
    if (response != null) {
      habitsModel.habits.add(response.data[0]);
    }
    notifyListeners();
  }

  Future editHabit(int index) async {
    DialogResponse response = await dialogService.showCustomDialog(
      variant: DialogType.habit,
      title: "Add Habit",
      data: [habitsModel.habits[index]],
      // description: "Enter the task you want to be reminded of: ",
      mainButtonTitle: 'Enter',
      barrierDismissible: true,
    );
    habitsModel.habits[index] = response.data[0];
    notifyListeners();
  }

  EditHabitsPageViewModel(DateTime t) {
    date = t;
    this.log = getLogger(this.runtimeType.toString());
  }

  void goBack() {
    navigationService.clearTillFirstAndShowView(DetailsPageTabBarView(
      selectedDate: date,
      index: 1,
    ));
  }

  @override
  Future futureToRun() async {
    habitsModel =
        await firestoreService.getAllHabits(authenticationService.user.uid);
  }

  Future dispose() async {
    await firestoreService.updateHabits(
        authenticationService.user.uid, habitsModel);
    super.dispose();
  }
}
