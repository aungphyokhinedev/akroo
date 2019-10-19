import 'package:flutter/material.dart';

enum MyThemeKeys { LIGHT, DARK, DARKER }

class MyThemes {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blueGrey,
    accentColor: Colors.blueGrey,
  //  buttonTheme: ButtonThemeData(buttonColor: Colors.white),

    backgroundColor: Colors.white,
    // Define the default font family.
    // fontFamily: 'Montserrat',

    // Define the default TextTheme. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
    textTheme: TextTheme(
      headline: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
      title: TextStyle(fontWeight: FontWeight.w400),
      body1: TextStyle(color: Colors.black38),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.orange,
    accentColor: Colors.orange,
    canvasColor: Colors.grey[850],
//cardColor:  Color(0xFF434949),
    buttonTheme: ButtonThemeData(buttonColor: Colors.white30),
    iconTheme: IconThemeData(color: Colors.white24),
    backgroundColor: Colors.blueGrey,
    // Define the default font family.
    //   fontFamily: 'Montserrat',

    // Define the default TextTheme. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
    textTheme: TextTheme(
      headline: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
      title: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
      body1: TextStyle(color: Colors.white38),
    ),
  );

  static final ThemeData darkerTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.red[800],
    accentColor: Colors.red[600],
    buttonTheme: ButtonThemeData(buttonColor: Colors.white30),
    canvasColor: Color(0xFF000000),
    iconTheme: IconThemeData(color: Colors.white24),
    backgroundColor: Colors.blueGrey,

    // Define the default font family.
    // fontFamily: 'Montserrat',

    // Define the default TextTheme. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
    textTheme: TextTheme(
      headline: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
      title: TextStyle(color: Colors.white70),
      body1: TextStyle(color: Colors.white38),
    ),
  );

  static ThemeData getThemeFromKey(MyThemeKeys themeKey) {
    switch (themeKey) {
      case MyThemeKeys.LIGHT:
        return lightTheme;
      case MyThemeKeys.DARK:
        return darkTheme;
      case MyThemeKeys.DARKER:
        return darkerTheme;
      default:
        return lightTheme;
    }
  }

  static Map<String, MyThemeKeys> get themes => {
        "Light Theme": MyThemeKeys.LIGHT,
        "Dark Theme": MyThemeKeys.DARK,
        "Darker Theme": MyThemeKeys.DARKER,
      };
}
