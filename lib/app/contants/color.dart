
import 'package:flutter/material.dart';

const appPurple = Color(0xFF431AA1);
const appPurpleDark = Color(0xFF1E0771);
const appPurpleLight1 = Color(0xFF9345F2);
const appPurpleLight2 = Color(0xFFB9A2D8);
const appWhite = Color(0xFFFAF8FC);
const appOrange = Color(0xFFE6704A);

ThemeData themeLight = ThemeData(
  brightness: Brightness.light,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: appPurpleDark,
  ),
  primaryColor: appPurpleDark,
  scaffoldBackgroundColor: appWhite,
  appBarTheme: AppBarTheme(
    backgroundColor: appPurpleDark,
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: appPurpleDark),
    bodyMedium: TextStyle(color: appPurpleDark),
    bodySmall: TextStyle(color: appPurpleDark),
  ),
  listTileTheme: ListTileThemeData(
    iconColor: appPurpleDark,
  ),
  tabBarTheme: TabBarThemeData(
    labelColor: appPurpleDark,
    unselectedLabelColor: appPurpleDark,
    indicator: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: appPurpleDark
        )
      )
    )
  )
);

ThemeData themeDark = ThemeData(
  brightness: Brightness.dark,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: appWhite,
  ),
  primaryColor: appPurpleLight2,
  scaffoldBackgroundColor: appPurpleDark,
  appBarTheme: AppBarTheme(
    backgroundColor: appPurpleDark,
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: appWhite),
    bodyMedium: TextStyle(color: appWhite),
    bodySmall: TextStyle(color: appWhite),
  ),
  listTileTheme: ListTileThemeData(
    iconColor: appWhite,
  ),
  tabBarTheme: TabBarThemeData(
    labelColor: appWhite,
    unselectedLabelColor: Colors.grey,
    indicator: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: appWhite
        )
      )
    )
  )
);
