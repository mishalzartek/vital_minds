import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:vitalminds/core/services/authentication_service.dart';
import 'package:vitalminds/core/services/background_music_service.dart';
import 'package:vitalminds/core/services/firestore_service.dart';
import 'package:vitalminds/views/OTP/OTP_view.dart';
import 'package:vitalminds/views/analytics_page/analytics_page_view.dart';
import 'package:vitalminds/views/calendar_page/calendar_page_view.dart';
import 'package:vitalminds/views/details_page_tab_bar/details_page_tab_bar_view.dart';
import 'package:vitalminds/views/email_verification_page/email_verification_view.dart';
import 'package:vitalminds/views/home/home_view.dart';
import 'package:vitalminds/views/introduction_page/introduction_view.dart';
import 'package:vitalminds/views/login/login_view.dart';
import 'package:vitalminds/views/registration/registration_view.dart';
import 'package:vitalminds/views/settings_page/settings_page_view.dart';
import 'package:vitalminds/views/splash/splash_view.dart';
import 'package:vitalminds/views/therapy_screen/therapy_screen_view.dart';
import 'package:vitalminds/views/worksheets/worksheets_view.dart';

// Run 'flutter pub run build_runner build --delete-conflicting-outputs' whenever this file is changed
@StackedApp(routes: [
  MaterialRoute(page: SplashView, initial: true, name: 'splashViewRoute'),
  MaterialRoute(page: LoginView, name: 'loginViewRoute'),
  MaterialRoute(page: IntroductionPageView, name: 'introductionViewRoute'),
  MaterialRoute(page: OTPView, name: 'otpViewRoute'),
  MaterialRoute(page: RegistrationView, name: 'registrationViewRoute'),
  MaterialRoute(page: EmailVerificcationView, name: 'emailVerificcationView'),
  MaterialRoute(page: HomeView, name: 'homeViewRoute'),
  MaterialRoute(page: AnalyticsPageView, name: 'analyticsPageViewRoute'),
  MaterialRoute(page: CalendarPageView, name: 'calendarPageViewRoute'),
  MaterialRoute(page: SettingsPageView, name: 'settingsPageViewRoute'),
  MaterialRoute(
      page: DetailsPageTabBarView, name: 'detailsPageTabBarViewRoute'),
  MaterialRoute(page: TherapyScreenView, name: 'therapyScreenViewRoute'),
  MaterialRoute(page: WorksheetsView, name: 'worksheetsViewRoute'),
], dependencies: [
  LazySingleton(classType: NavigationService),
  LazySingleton(classType: DialogService),
  LazySingleton(classType: SnackbarService),
  LazySingleton(classType: AuthenticationService),
  LazySingleton(classType: FirestoreService),
  LazySingleton(classType: BackgroundMusicService),
])
class AppSetup {
  /** Serves no purpose besides having an annotation attached to it */
}
