import 'package:flutter/material.dart';

class DefaultColors {
  static Color subtitleColor = Color(0xFF9C9EA6);
  static Color backgroundColor = Color(0xFF202233);
  static Color primaryColor = Color(0xFF4558FE);
  static Color secondaryColor = Color(0xFF353A50);
  static Color accentColor = Color(0xFF3ACCE1);
}

var textTheme = TextTheme(
  displayLarge: TextStyle(fontSize: 52, color: Colors.white),
  displayMedium: TextStyle(fontSize: 40, color: Colors.white),
  displaySmall: TextStyle(fontSize: 29, color: Colors.white),
  headlineMedium: TextStyle(fontSize: 24, color: Colors.white),
  headlineSmall: TextStyle(fontSize: 20, color: DefaultColors.subtitleColor),
  bodyMedium: TextStyle(fontSize: 18, color: DefaultColors.subtitleColor),
  bodySmall: TextStyle(fontSize: 14, color: DefaultColors.subtitleColor),
  labelLarge: TextStyle(fontSize: 16, color: DefaultColors.subtitleColor),
);

var inputDecoration = InputDecorationTheme(
  labelStyle: TextStyle(fontFamily: 'Gibson', color: Color(0xFF6E768A)),
  contentPadding: EdgeInsets.all(10),
  filled: true,
  errorStyle: TextStyle(fontSize: 16),
  fillColor: Color(0xFF353D50),
  border: UnderlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.all(
      Radius.circular(15),
    ),
  ),
);

var buttonTheme = ButtonThemeData(
  colorScheme: ColorScheme.light(
    primary: DefaultColors.primaryColor,
    secondary: DefaultColors.secondaryColor,
  ),
);

var theme = ThemeData(
  unselectedWidgetColor: Colors.white,
  primaryColor: DefaultColors.primaryColor,
  primaryColorDark: DefaultColors.backgroundColor,
  colorScheme: ColorScheme.light(
    primary: DefaultColors.primaryColor,
    secondary: DefaultColors.secondaryColor,
  ),
  scaffoldBackgroundColor: DefaultColors.backgroundColor,
  fontFamily: 'Gibson',
  canvasColor: Color(0xFF353D50),
  textTheme: textTheme,
  inputDecorationTheme: inputDecoration,
  buttonTheme: buttonTheme,
  tabBarTheme: TabBarTheme(
    labelStyle: TextStyle(fontFamily: 'Gibson'),
    unselectedLabelStyle: TextStyle(fontFamily: 'Gibson'),
  ),
);
