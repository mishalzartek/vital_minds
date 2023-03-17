// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../views/OTP/OTP_view.dart';
import '../../views/analytics_page/analytics_page_view.dart';
import '../../views/calendar_page/calendar_page_view.dart';
import '../../views/details_page_tab_bar/details_page_tab_bar_view.dart';
import '../../views/email_verification_page/email_verification_view.dart';
import '../../views/home/home_view.dart';
import '../../views/introduction_page/introduction_view.dart';
import '../../views/login/login_view.dart';
import '../../views/registration/registration_view.dart';
import '../../views/settings_page/settings_page_view.dart';
import '../../views/splash/splash_view.dart';
import '../../views/therapy_screen/therapy_screen_view.dart';
import '../../views/worksheets/worksheets_view.dart';

class Routes {
  static const String splashViewRoute = '/';
  static const String loginViewRoute = '/login-view';
  static const String introductionViewRoute = '/introduction-page-view';
  static const String otpViewRoute = '/o-tp-view';
  static const String registrationViewRoute = '/registration-view';
  static const String emailVerificcationViewRoute = '/email-verificcation-view';
  static const String homeViewRoute = '/home-view';
  static const String healthPageViewRoute = '/health-page-view';
  static const String analyticsPageViewRoute = '/analytics-page-view';
  static const String calendarPageViewRoute = '/calendar-page-view';
  static const String settingsPageViewRoute = '/settings-page-view';
  static const String detailsPageTabBarViewRoute = '/details-page-tab-bar-view';
  static const String therapyScreenViewRoute = '/therapy-screen-view';
  static const String worksheetsViewRoute = '/worksheets-view';
  static const all = <String>{
    splashViewRoute,
    loginViewRoute,
    introductionViewRoute,
    otpViewRoute,
    registrationViewRoute,
    emailVerificcationViewRoute,
    homeViewRoute,
    healthPageViewRoute,
    analyticsPageViewRoute,
    calendarPageViewRoute,
    settingsPageViewRoute,
    detailsPageTabBarViewRoute,
    therapyScreenViewRoute,
    worksheetsViewRoute,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.splashViewRoute, page: SplashView),
    RouteDef(Routes.loginViewRoute, page: LoginView),
    RouteDef(Routes.introductionViewRoute, page: IntroductionPageView),
    RouteDef(Routes.otpViewRoute, page: OTPView),
    RouteDef(Routes.registrationViewRoute, page: RegistrationView),
    // RouteDef(Routes.emailVerificcationViewRoute, page: EmailVerificcationView),
    RouteDef(Routes.homeViewRoute, page: HomeView),
    RouteDef(Routes.analyticsPageViewRoute, page: AnalyticsPageView),
    RouteDef(Routes.calendarPageViewRoute, page: CalendarPageView),
    RouteDef(Routes.settingsPageViewRoute, page: SettingsPageView),
    RouteDef(Routes.detailsPageTabBarViewRoute, page: DetailsPageTabBarView),
    RouteDef(Routes.therapyScreenViewRoute, page: TherapyScreenView),
    RouteDef(Routes.worksheetsViewRoute, page: WorksheetsView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    SplashView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SplashView(),
        settings: data,
      );
    },
    LoginView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => LoginView(),
        settings: data,
      );
    },
    IntroductionPageView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => IntroductionPageView(),
        settings: data,
      );
    },
    OTPView: (data) {
      var args = data.getArgs<OTPViewArguments>(
        orElse: () => OTPViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => OTPView(
          key: args.key,
          login: args.login,
          registration: args.registration,
        ),
        settings: data,
      );
    },
    RegistrationView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => RegistrationView(),
        settings: data,
      );
    },
    // EmailVerificcationView: (data) {
    //   return MaterialPageRoute<dynamic>(
    //     builder: (context) => EmailVerificcationView(),
    //     settings: data,
    //   );
    // },
    HomeView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomeView(),
        settings: data,
      );
    },
    AnalyticsPageView: (data) {
      var args = data.getArgs<AnalyticsPageViewArguments>(
        orElse: () => AnalyticsPageViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => AnalyticsPageView(
          key: args.key,
          selectedDate: args.selectedDate,
        ),
        settings: data,
      );
    },
    CalendarPageView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => CalendarPageView(),
        settings: data,
      );
    },
    SettingsPageView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SettingsPageView(),
        settings: data,
      );
    },
    DetailsPageTabBarView: (data) {
      var args = data.getArgs<DetailsPageTabBarViewArguments>(
        orElse: () => DetailsPageTabBarViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => DetailsPageTabBarView(
          key: args.key,
          selectedDate: args.selectedDate,
        ),
        settings: data,
      );
    },
    TherapyScreenView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => TherapyScreenView(0),
        settings: data,
      );
    },
    WorksheetsView: (data) {
      var args = data.getArgs<WorksheetsViewArguments>(
        orElse: () => WorksheetsViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => WorksheetsView(
          selectedDay: args.selectedDay,
        ),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// DetailsPageTabBarView arguments holder class
class DetailsPageTabBarViewArguments {
  final Key key;
  final DateTime selectedDate;
  DetailsPageTabBarViewArguments({this.key, this.selectedDate});
}

class WorksheetsViewArguments {
  final DateTime selectedDay;
  WorksheetsViewArguments({this.selectedDay});
}

class OTPViewArguments {
  final Key key;
  final bool login;
  bool registration = true;
  OTPViewArguments({this.login, this.key, this.registration});
}

class AnalyticsPageViewArguments {
  final Key key;
  final DateTime selectedDate;
  AnalyticsPageViewArguments({this.key, this.selectedDate});
}
