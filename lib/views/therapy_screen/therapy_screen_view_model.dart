import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:vitalminds/core/app/logger.dart';

class TherapyScreenViewModel extends BaseViewModel {
  Logger log;
  int _currentIndex = 0;
  Color tabColor = Colors.white.withOpacity(0.45);
  int get currentIndex => _currentIndex;

  void setTabColor() {
    tabColor = Color.fromRGBO(62, 172, 194, 1);
    notifyListeners();
  }

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  TherapyScreenViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
