import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:vitalminds/core/app/app.locator.dart';
import 'package:vitalminds/core/app/app.router.dart';
import 'package:vitalminds/core/app/logger.dart';
import 'package:vitalminds/core/services/authentication_service.dart';
import 'package:vitalminds/core/services/firestore_service.dart';
import 'package:local_auth/local_auth.dart';

class SplashViewModel extends BaseViewModel {
  Logger log;
  SharedPreferences prefs;
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  NavigationService _navigationService = locator<NavigationService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();

  SplashViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  Future<bool> checkNet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
      return false;
    } on SocketException catch (_) {
      Fluttertoast.showToast(
          msg: "No internet found", gravity: ToastGravity.BOTTOM);
      return false;
    }
  }

  Future init() async {
    log.i('handleStartUpLogic called');
    bool check = await checkNet();
    if (check) {
      bool hasUserLoggedIn = _authenticationService.isUserLoggedIn();
      bool isEmailVerified = _authenticationService.isEmailVerified();
      log.i("hasUserLoggedIn: " + hasUserLoggedIn.toString());
      if (hasUserLoggedIn) {
        if (await _firestoreService
            .isUserDataPresent(_authenticationService.user.uid)) {
          log.i('User is currently logged in and data is present in database');
          await _authenticationService
              .populateCurrentUser(_authenticationService.user);

          prefs = await SharedPreferences.getInstance();
          bool applock = prefs.getBool("enableAppLock") ?? false;
          if (applock == true) {
            bool isAuthenticated =
                await Authentication.authenticateWithBiometrics();

            if (isAuthenticated) {
              if (isEmailVerified) {
                _navigationService.clearStackAndShow(Routes.homeViewRoute);
              } else {
                _navigationService
                    .clearStackAndShow(Routes.emailVerificcationViewRoute);
              }
            } else {
              log.i('Local authentication failed.');
              init();
            }
          } else {
            if (isEmailVerified) {
              _navigationService.clearStackAndShow(Routes.homeViewRoute);
            } else {
              _navigationService
                  .clearStackAndShow(Routes.emailVerificcationViewRoute);
            }
          }
        } else {
          log.i(
              'User is currently logged in and data is not present in database');
          if (isEmailVerified) {
            await _navigationService.clearStackAndShow(Routes.homeViewRoute);
          } else {
            await _navigationService
                .clearStackAndShow(Routes.emailVerificcationViewRoute);
          }
        }
      } else {
        prefs = await SharedPreferences.getInstance();
        bool isFirst = prefs.getBool("isFirst") ?? true;
        if (isFirst) {
          _navigationService.clearStackAndShow(Routes.introductionViewRoute);
        } else {
          log.i('No user is currently logged in');
          _navigationService.clearStackAndShow(Routes.loginViewRoute);
        }
      }
    } else {
      Fluttertoast.showToast(msg: "No Internet found");
      prefs = await SharedPreferences.getInstance();
      bool isFirst = prefs.getBool("isFirst") ?? true;
      if (isFirst) {
        _navigationService.clearStackAndShow(Routes.introductionViewRoute);
      } else {
        if (_authenticationService.isUserLoggedIn() == false) {
          log.i('No user is currently logged in');
          _navigationService.clearStackAndShow(Routes.loginViewRoute);
        } else {
          if (_authenticationService.isEmailVerified()) {
            await _navigationService.clearStackAndShow(Routes.homeViewRoute);
          } else {
            await _navigationService
                .clearStackAndShow(Routes.emailVerificcationViewRoute);
          }
        }
      }
    }
  }
}

class Authentication {
  static Future<bool> authenticateWithBiometrics() async {
    final LocalAuthentication localAuthentication = LocalAuthentication();
    bool isBiometricSupported = await localAuthentication.isDeviceSupported();
    bool canCheckBiometrics = await localAuthentication.canCheckBiometrics;

    bool isAuthenticated = false;

    if (isBiometricSupported && canCheckBiometrics) {
      const iosStrings = const IOSAuthMessages(
          cancelButton: 'cancel',
          goToSettingsButton: 'settings',
          goToSettingsDescription: 'Please set up your Touch ID.',
          lockOut: 'Please re-enable your Touch ID');
      isAuthenticated = await localAuthentication.authenticate(
        iOSAuthStrings: iosStrings,
        localizedReason:
            'Enter Password/Pin/Fingerprint/Face ID to Unlock VitalMinds. You can Disable this in settings.',
      );
    }

    return isAuthenticated;
  }
}
