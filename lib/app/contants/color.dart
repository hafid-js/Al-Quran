import 'package:flutter/material.dart';

const appPurple = Color(0xFF431AA1);
const appPurpleDark = Color.fromARGB(255, 45, 25, 120);
const appPurpleLight1 = Color(0xFF9345F2);
const appPurpleLight2 = Color(0xFFB9A2D8);
const appWhite = Color(0xFFFAF8FC);
const appOrange = Color(0xFFE6704A);

ThemeData themeLight = ThemeData(
  fontFamily: 'Quicksand',
  brightness: Brightness.light,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: appPurpleDark,
  ),
  primaryColor: appPurpleDark,
  scaffoldBackgroundColor: appWhite,
  appBarTheme: AppBarTheme(backgroundColor: appWhite),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: appPurpleDark, fontWeight: FontWeight.bold),
    bodyMedium: TextStyle(color: appPurpleDark, fontWeight: FontWeight.bold),
    bodySmall: TextStyle(color: appPurpleDark, fontWeight: FontWeight.bold),
  ),
  listTileTheme: ListTileThemeData(iconColor: appPurpleDark),
  tabBarTheme: TabBarThemeData(
    labelColor: appPurpleDark,
    unselectedLabelColor: appPurpleDark,
    indicator: BoxDecoration(
      border: Border(bottom: BorderSide(color: appPurpleDark)),
    ),
  ),
);

ThemeData themeDark = ThemeData(
  fontFamily: 'Quicksand',
  brightness: Brightness.dark,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: appWhite,
  ),
  primaryColor: appPurpleLight2,
  scaffoldBackgroundColor: appPurpleDark,
  appBarTheme: AppBarTheme(backgroundColor: appPurpleDark),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: appWhite, fontWeight: FontWeight.bold),
    bodyMedium: TextStyle(color: appWhite, fontWeight: FontWeight.bold),
    bodySmall: TextStyle(color: appWhite, fontWeight: FontWeight.bold),
  ),
  listTileTheme: ListTileThemeData(iconColor: appWhite),
  tabBarTheme: TabBarThemeData(
    labelColor: appWhite,
    unselectedLabelColor: Colors.grey,
    indicator: BoxDecoration(
      border: Border(bottom: BorderSide(color: appWhite)),
    ),
  ),
);
