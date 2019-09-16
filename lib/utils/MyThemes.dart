import 'package:flutter/material.dart';

enum MyThemeKeys { LIGHT, DARK, DARKER }

class MyThemes {
  static final ThemeData lightTheme = ThemeData(
   brightness: Brightness.light,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],

        // Define the default font family.
       // fontFamily: 'Montserrat',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
       //   title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
       //   body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],

        // Define the default font family.
     //   fontFamily: 'Montserrat',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        //  title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
      //    body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
  );

  static final ThemeData darkerTheme = ThemeData(
    brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],

        // Define the default font family.
       // fontFamily: 'Montserrat',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
       //   title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
       //   body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
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
}