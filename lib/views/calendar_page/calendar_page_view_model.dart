import 'dart:math';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:vitalminds/core/app/app.locator.dart';
import 'package:vitalminds/core/app/logger.dart';
import 'package:vitalminds/views/details_page_tab_bar/details_page_tab_bar_view.dart';

class CalendarPageViewModel extends BaseViewModel {
  Logger log;
  NavigationService navigationService = locator<NavigationService>();
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  DateTime start = DateTime(1900, 1, 1);
  DateTime last = DateTime.now();
  String data = " ";
  Random r = Random(DateTime.now().day);
  List<String> lines = [];
  List<String> line = [];

  void onDaySelected(DateTime s, DateTime f) {
    if (!isSameDay(selectedDay, s)) {
      selectedDay = s;
      focusedDay = f;
      notifyListeners();
    }
    log.d("date selected in calendar is : " + focusedDay.toString());
  }

  void navigateToDetailsTabPage() {
    notifyListeners();
    log.d("date selected while calling details tab bar is : " +
        focusedDay.toString() +
        "  " +
        selectedDay.toString());
    navigationService.navigateWithTransition(
        DetailsPageTabBarView(selectedDate: focusedDay),
        transition: 'scale');
  }

  void initialise() {
    generateQuotes();
    notifyListeners();
  }

  Future<void> generateQuotes() async {
    final _loadedData = await rootBundle.loadString('assets/files/quotes.txt');
    var temp = _loadedData;
    notifyListeners();
    lines = temp.split("\n");
    line = lines[r.nextInt(101)].split("\"");
    data = line[1] + ' ' + line[2];
    notifyListeners();
  }

  CalendarPageViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    notifyListeners();
  }
}
