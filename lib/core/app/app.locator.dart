// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'dart:developer';

import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked_themes/stacked_themes.dart';

import '../services/authentication_service.dart';
import '../services/background_music_service.dart';
import '../services/firestore_service.dart';

final locator = StackedLocator.instance.locator;

void setupLocator() {
  try {
    locator.registerLazySingleton(() => NavigationService());
    locator.registerLazySingleton(() => DialogService());
    locator.registerLazySingleton(() => SnackbarService());
    locator.registerLazySingleton(() => AuthenticationService());
    locator.registerLazySingleton(() => FirestoreService());
    locator.registerLazySingleton(() => BackgroundMusicService());
    locator.registerSingleton(ThemeService.getInstance());
  } catch (e) {
    log("setupLocator: " + e.toString());
  }
}
