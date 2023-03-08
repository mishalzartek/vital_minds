import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:vitalminds/core/app/app.locator.dart';
import 'package:vitalminds/views/settings_page/settings_page_view.dart';

class AboutUsPageViewModel extends BaseViewModel {
  NavigationService navigationService = locator<NavigationService>();
  void navigateToProfilePage() {
    navigationService.navigateWithTransition(
      SettingsPageView(),
      transitionStyle: Transition.leftToRight,
    );
  }
}
