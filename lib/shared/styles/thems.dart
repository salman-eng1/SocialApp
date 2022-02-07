import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';
import 'colors.dart';
import 'colors.dart';

ThemeData lightTheme=ThemeData(
  fontFamily: 'Jannah',
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    titleSpacing: 20.0,
    iconTheme: IconThemeData(
      color: defaultColor,
    ),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(

    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey.shade400,
    elevation: 20.0,
    backgroundColor: Colors.white,

  ),
  // floatingActionButtonTheme: FloatingActionButtonThemeData(
  //   backgroundColor: defaultColor,
  // ),
  textTheme: TextTheme(
      bodyText1: TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  ),
    subtitle1: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
      height: 1.3
    ),
  ),
);


ThemeData darkTheme=ThemeData(
  fontFamily: 'Jannah',
  scaffoldBackgroundColor: Colors.grey.shade700,
  primarySwatch: defaultColor,
  appBarTheme: AppBarTheme(
    titleSpacing: 20.0,
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.grey.shade700,
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: Colors.grey.shade700,
    elevation: 0.0,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey.shade200,
    elevation: 20.0,
    backgroundColor: Colors.grey.shade700,

  ),
  // floatingActionButtonTheme: FloatingActionButtonThemeData(
  //   backgroundColor: defaultColor,
  // ),
  textTheme: TextTheme(
      bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.white
  ),
    subtitle1: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
      height: 1.3,
    ),
  ),
);