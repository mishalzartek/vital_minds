import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:vitalminds/core/app/logger.dart';

class WorksheetsViewModel extends BaseViewModel {
  Logger log;

  WorksheetsViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
