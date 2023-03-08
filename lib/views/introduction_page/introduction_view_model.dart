import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:vitalminds/core/app/app.locator.dart';
import 'package:vitalminds/core/app/app.router.dart';

class IntroductionPageViewModel extends BaseViewModel {
  NavigationService navigationService = locator<NavigationService>();
  SharedPreferences prefs;
  void navigateToHomePage() async {
    prefs = await SharedPreferences.getInstance();
    prefs.setBool("isFirst", false);
    navigationService.clearStackAndShow(Routes.loginViewRoute);
  }
}
