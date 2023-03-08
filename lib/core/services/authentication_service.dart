import 'package:firebase_auth/firebase_auth.dart' as firebaseAuth;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:vitalminds/core/app/app.locator.dart';
import 'package:vitalminds/core/app/logger.dart';
import 'package:vitalminds/core/models/user_model.dart';
import 'package:vitalminds/views/login/login_view.dart';
import 'package:vitalminds/views/splash/splash_view.dart';

import 'firestore_service.dart';

class AuthenticationService {
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final firebaseAuth.FirebaseAuth _firebaseAuth =
      firebaseAuth.FirebaseAuth.instance;
  Logger log = getLogger('AuthenticationService');
  String _smsVerificationCode;
  String phoneNumber;
  firebaseAuth.User user;
  User _currentUser;
  String name, age;

  bool isEmailVerified() {
    if (isUserLoggedIn()) {
      log.i('user logged in');
      log.i(_firebaseAuth.currentUser.emailVerified.toString());
      return _firebaseAuth.currentUser.emailVerified;
    } else {
      return false;
    }
  }

  User get currentUser => _currentUser;

  void setCurrentUser(User user) {
    _currentUser = user;
  }

  Future changePassword(firebaseAuth.User u, String password) async {
    /* u.reauthenticateWithCredential(firebaseAuth.EmailAuthProvider.credential(
      email: u.email, password:oldPassword
    )).then((value){

     need to figure out a way to re-authenticate the user before changing password

    }).catchError((err){
      log.i(err);
    });*/
    try {
      await u
          .updatePassword(password)
          .then((value) => log.i('password changed'));
    } on firebaseAuth.FirebaseException catch (e) {
      Fluttertoast.showToast(
          msg: e.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future loginWithEmail(
      {@required String email,
      @required String password,
      String age,
      String name}) async {
    log.i('loginWithEmail called');
    try {
      firebaseAuth.UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        user = userCredential.user;
        Fluttertoast.showToast(
            timeInSecForIosWeb: 2,
            msg: "Authentication successful!",
            gravity: ToastGravity.BOTTOM);
        if (await _firestoreService.isUserDataPresent(user.uid)) {
          await populateCurrentUser(user);
          await _navigationService.replaceWithTransition(SplashView(),
              transitionStyle: Transition.rightToLeft);
          // await _navigationService.navigateTo(Routes.splashViewRoute);
        } else {
          await user.updateDisplayName(name);
          _firestoreService.createUser(
              User(age: age, email: user.email), user.uid);
          // await _navigationService.navigateTo(Routes.splashViewRoute);
          await _navigationService.replaceWithTransition(SplashView(),
              transitionStyle: Transition.rightToLeft);
        }
      }
    } on firebaseAuth.FirebaseException catch (e) {
      log.e(e.message);
      Fluttertoast.showToast(
          timeInSecForIosWeb: 2,
          msg:
              "Authentication failed. Please check your credentials or try again later.");
    }
  }

  Future forgotPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      rethrow;
    }
  }

  Future sendVerificationEmail() async {
    try {
      await user.sendEmailVerification();
    } catch (e) {
      log.i(e.toString());
      Fluttertoast.showToast(
          timeInSecForIosWeb: 2, msg: e.message, gravity: ToastGravity.BOTTOM);
    }
  }

  Future signUpWithEmail({
    @required String email,
    @required String password,
    @required String name,
    @required String age,
  }) async {
    log.i('signUpWithEmail called');
    firebaseAuth.UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    if (userCredential.user != null) {
      user = userCredential.user;
      Fluttertoast.showToast(
          timeInSecForIosWeb: 2,
          msg: "Authentication successful!",
          gravity: ToastGravity.BOTTOM);
      if (await _firestoreService.isUserDataPresent(user.uid)) {
        await populateCurrentUser(user);
        // await _navigationService.navigateTo(Routes.splashViewRoute);
        await _navigationService.replaceWithTransition(SplashView(),
            transitionStyle: Transition.rightToLeft);
      } else {
        await user.updateDisplayName(name);
        _firestoreService.createUser(
            User(age: age, email: user.email), user.uid);
        // await _navigationService.navigateTo(Routes.splashViewRoute);
        await _navigationService.replaceWithTransition(SplashView(),
            transitionStyle: Transition.rightToLeft);
      }
    }
  }

  Future<void> loginWithPhoneNumber(
      {@required String phoneNumber, String age, String name}) async {
    log.i('verifyPhoneNumber called');
    this.age = age;
    this.name = name;
    try {
      //await _firebaseAuth.setSettings(appVerificationDisabledForTesting: true);
      this.phoneNumber = phoneNumber;
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: Duration(seconds: 30),
        verificationCompleted: (authCredential) =>
            _verificationComplete(authCredential),
        verificationFailed: (authException) =>
            _verificationFailed(authException),
        codeAutoRetrievalTimeout: (verificationId) =>
            _codeAutoRetrievalTimeout(verificationId),

        // called when the SMS code is sent
        codeSent: (verificationId, [code]) =>
            _smsCodeSent(verificationId, [code]),
      );
      log.i('verifyPhoneNumber terminates');
    } catch (e) {
      log.e(e.message);
      _snackbarService.showSnackbar(message: e.message);
    }
  }

  // will get an AuthCredential object that will help with logging into Firebase.
  Future<void> _verificationComplete(
      firebaseAuth.AuthCredential _authCredential) async {
    log.i("_verificationComplete called");
    try {
      firebaseAuth.UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(_authCredential);
      if (userCredential.user != null) {
        user = userCredential.user;
        Fluttertoast.showToast(
            timeInSecForIosWeb: 2,
            msg: "Authentication successful!",
            gravity: ToastGravity.BOTTOM);
        if (await _firestoreService.isUserDataPresent(user.uid)) {
          await populateCurrentUser(user);
          // await _navigationService.navigateTo(Routes.splashViewRoute);
          await _navigationService.replaceWithTransition(SplashView(),
              transitionStyle: Transition.rightToLeft);
        } else {
          user.updateDisplayName(name).whenComplete(() {
            _firestoreService.createUser(
                User(age: age, email: user.email), user.uid);
            // _navigationService.navigateTo(Routes.splashViewRoute);
            _navigationService.replaceWithTransition(SplashView(),
                transitionStyle: Transition.rightToLeft);
          });
        }
      }
    } catch (e) {
      _snackbarService.showSnackbar(message: e.toString());
    }
  }

  Future<void> _smsCodeSent(String verificationId, List<int> code) async {
    // set the verification code so that we can use it to log the user in
    log.i('_smsCodeSent called');
    _smsVerificationCode = verificationId;
  }

  Future<void> _verificationFailed(
      firebaseAuth.FirebaseAuthException authException) async {
    log.i('_verificationFailed called');
    log.e(authException.message);
    if (authException.message.contains('not authorized'))
      await _dialogService.showDialog(
        title: 'Login Failure',
        description: 'Something has gone wrong, please try later',
      );
    else if (authException.message.contains('Network'))
      await _dialogService.showDialog(
        title: 'Login Failure',
        description: 'Please check your internet connection and try again',
      );
    else
      await _dialogService.showDialog(
        title: 'Login Failure',
        description: 'Something has gone wrong, please try later',
      );
    // _navigationService.navigateTo(Routes.loginViewRoute);
    _navigationService.replaceWithTransition(LoginView(),
        transitionStyle: Transition.rightToLeft);
  }

  Future<void> _codeAutoRetrievalTimeout(String verificationId) async {
    // set the verification code so that we can use it to log the user in
    log.i('_codeAutoRetrievalTimeout called');
    _smsVerificationCode = verificationId;

    _snackbarService.showSnackbar(
      title: 'Code Auto Retrieval Timeout',
      message: 'Auto retrieval of code failed. Please enter the code manually',
    );
    //await _navigationService.navigateTo(Routes.otpViewRoute);
  }

  Future signInWithOTP({String otpCode, bool login}) async {
    log.i('signInWithOTP called');
    if (otpCode.length != 6) {
      _snackbarService.showSnackbar(message: 'Invalid OTP');
    } else {
      firebaseAuth.AuthCredential _authCredential =
          firebaseAuth.PhoneAuthProvider.credential(
              verificationId: _smsVerificationCode, smsCode: otpCode);
      try {
        firebaseAuth.UserCredential userCredential =
            await _firebaseAuth.signInWithCredential(_authCredential);
        if (userCredential.additionalUserInfo.isNewUser) {
          await userCredential.user.delete();
          Fluttertoast.showToast(
              timeInSecForIosWeb: 2,
              msg: "U need to register first!",
              gravity: ToastGravity.BOTTOM);
          await _navigationService.replaceWithTransition(LoginView(),
              transitionStyle: Transition.rightToLeft);
        }
        if (userCredential.user != null) {
          user = userCredential.user;
          Fluttertoast.showToast(
              timeInSecForIosWeb: 2,
              msg: "Authentication successful!",
              gravity: ToastGravity.BOTTOM);
          if (await _firestoreService.isUserDataPresent(user.uid)) {
            await populateCurrentUser(user);
            // await _navigationService.navigateTo(Routes.splashViewRoute);
            await _navigationService.replaceWithTransition(SplashView(),
                transitionStyle: Transition.rightToLeft);
          } else {
            user.updateDisplayName(name).whenComplete(() async {
              print("profile updated");
              _firestoreService.createUser(
                  User(age: age, phno: user.phoneNumber), user.uid);
              // await _navigationService.navigateTo(Routes.splashViewRoute);
              await _navigationService.replaceWithTransition(SplashView(),
                  transitionStyle: Transition.rightToLeft);
            });
          }
        }
      } catch (e) {
        log.e(e.toString());
        _snackbarService.showSnackbar(
            message: 'Something has gone wrong, please try later');
      }
    }
  }

  bool isUserLoggedIn() {
    log.i('isUserLoggedIn called');
    user = _firebaseAuth.currentUser;
    return user != null;
  }

  Future signOut() async {
    log.i('signOut called');
    try {
      await _firebaseAuth.signOut();
      log.i('Logged out Successfully ');
      return true;
    } catch (e) {
      log.e(e.message);
      return e.message;
    }
  }

  Future populateCurrentUser(firebaseAuth.User user) async {
    log.i('populateCurrentUser called');
    if (user != null) {
      _currentUser = await _firestoreService.getUser(user.uid);
    }
  }
}
