import 'package:firebase_auth/firebase_auth.dart' as firebaseAuth;
import 'package:firebase_auth/firebase_auth.dart';
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

  User get currentUser => _currentUser;

  void setCurrentUser(User user) {
    _currentUser = user;
  }

  // bool isEmailVerified() {
  //   if (isUserLoggedIn()) {
  //     log.i('user logged in');
  //     log.i(_firebaseAuth.currentUser.emailVerified.toString());
  //     return _firebaseAuth.currentUser.emailVerified;
  //   } else {
  //     return false;
  //   }
  // }

  Future changePassword(firebaseAuth.User user, String password) async {
    try {
      await user
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

  Future forgotPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> loginWithPhoneNumber(
      {@required String phoneNumber, String age, String name}) async {
    log.i('verifyPhoneNumber called');
    this.age = age;
    this.name = name;
    try {
      this.phoneNumber = phoneNumber;
      print('phn num : $phoneNumber');
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: "$phoneNumber",
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _firebaseAuth.signInWithCredential(credential).then((value) {
            log.e("You are logged in successfully");
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e);
          Fluttertoast.showToast(
            msg: "Verification Failed try Again",
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
          );
        },
        codeSent: (verificationId, [code]) =>
            _smsCodeSent(verificationId, [code]),
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
      log.i('verifyPhoneNumber terminates');
    } catch (e) {
      print(e);
      _snackbarService.showSnackbar(message: e.message);
    }
  }

  Future<void> _smsCodeSent(String verificationId, List<int> code) async {
    log.i('_smsCodeSent called');
    _smsVerificationCode = verificationId;
  }

  Future signInWithOTP({String otpCode, bool login, bool registration}) async {
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
        if (registration != null) {
          if (!registration) {
            if (userCredential.additionalUserInfo.isNewUser) {
              await userCredential.user.delete();
              Fluttertoast.showToast(
                  timeInSecForIosWeb: 2,
                  msg: "U need to register first!",
                  gravity: ToastGravity.BOTTOM);
              await _navigationService.replaceWithTransition(LoginView(),
                  transitionStyle: Transition.rightToLeft);
            }
          }
        }
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
          } else {
            user.updateDisplayName(name).whenComplete(() async {
              print("profile updated");
              _firestoreService.createUser(
                  UserModel(age: age, phno: user.phoneNumber), user.uid);

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
      try {
        _currentUser = await _firestoreService.getUser(user.uid);
      } catch (e) {
        print(e);
      }
    }
  }
}
