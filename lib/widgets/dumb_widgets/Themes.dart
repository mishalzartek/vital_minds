import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ThemeColors {
  Future<void> changeColors(Color value);
  Future<void> changeTheme(Color value);
  List<ThemeData> getThemes();
}

class Themes implements ThemeColors {
  SharedPreferences prefs;
  List<ThemeData> getThemes() {
    return [
      ThemeData(
        primaryColor: Color(0xff5a5ed0),
        backgroundColor: Color(0xff5a5ed0),
        textSelectionTheme: TextSelectionThemeData(
          selectionHandleColor: Color(0xff5a5ed0),
          selectionColor:Color(0xff5a5ed0).withOpacity(0.3),
        ),
      ),
      ThemeData(
        primaryColor: Color.fromRGBO(143, 41, 116, 1),
        backgroundColor: Color.fromRGBO(143, 41, 116, 1),
        textSelectionTheme: TextSelectionThemeData(
          selectionHandleColor: Color.fromRGBO(143, 41, 116, 1),
          selectionColor: Color.fromRGBO(143, 41, 116, 1).withOpacity(0.3),
        ),
      ),
      ThemeData(
        primaryColor: Color.fromRGBO(62, 147, 194, 1),
        backgroundColor: Color.fromRGBO(62, 147, 194, 1),
        textSelectionTheme: TextSelectionThemeData(
          selectionHandleColor: Color.fromRGBO(62, 147, 194, 1),
          selectionColor: Color.fromRGBO(62, 147, 194, 1).withOpacity(0.3),
        ),
      ),
      ThemeData(
        primaryColor: Color.fromRGBO(101, 163, 182, 1),
        backgroundColor: Color.fromRGBO(101, 163, 182, 1),
        textSelectionTheme: TextSelectionThemeData(
          selectionHandleColor: Color.fromRGBO(101, 163, 182, 1),
          selectionColor:Color.fromRGBO(101, 163, 182, 1).withOpacity(0.3),
        ),
      ),
      ThemeData(
        primaryColor: Color.fromRGBO(0, 148, 230, 1),
        backgroundColor:Color.fromRGBO(0, 148, 230, 1),
        textSelectionTheme: TextSelectionThemeData(
          selectionHandleColor: Color.fromRGBO(0, 148, 230, 1),
          selectionColor: Color.fromRGBO(0, 148, 230, 1).withOpacity(0.3),
        ),
      ),
      ThemeData(
        primaryColor: Color.fromRGBO(216, 142, 99, 1),
        backgroundColor: Color.fromRGBO(216, 142, 99, 1),
        textSelectionTheme: TextSelectionThemeData(
          selectionHandleColor: Color.fromRGBO(216, 142, 99, 1),
          selectionColor:Color.fromRGBO(216, 142, 99, 1).withOpacity(0.3),
        ),
      )
    ];
  }
  // #CA6BB1
  // #8DC9DB
  // #99CFEC
  // #91D3D8
  // #E9B698
  // #9498F3
  static final List colors = [
    Color(0xff5a5ed0),
    Color.fromRGBO(143, 41, 116, 1),
    Color.fromRGBO(62, 147, 194, 1),
    Color.fromRGBO(101, 163, 182, 1),
    Color.fromRGBO(0, 148, 230, 1),
    Color.fromRGBO(216, 142, 99, 1)
  ];

  static Color color = Color(0xff5a5ed0);
  static ColorFilter bgMode =
      ColorFilter.mode(Color(0xff5a5ed0).withOpacity(0.28), BlendMode.overlay);
  Future<void> changeColors(Color value) async {
    prefs = await SharedPreferences.getInstance();
    color = value;
    prefs.setInt("cacheColor", value.value);
  }

  Future<void> changeTheme(Color value) async {
    prefs = await SharedPreferences.getInstance();
    bgMode = ColorFilter.mode(value.withOpacity(0.3), BlendMode.overlay);
    prefs.setInt("cacheTheme", value.withOpacity(0.3).value);
  }
}
