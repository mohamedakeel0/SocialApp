import 'package:firebase1/shared/network/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData darkTheme = ThemeData(
    primarySwatch: defaultcolor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: defaultcolor,
    ),
    appBarTheme: AppBarTheme(
        titleSpacing: 20,
        backgroundColor: HexColor('#033E3E'),
        backwardsCompatibility: false,
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: HexColor('#033E3E'),
            statusBarBrightness: Brightness.light),
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        iconTheme: IconThemeData(color: Colors.white)),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: HexColor('#033E3E'),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: defaultcolor,
        unselectedItemColor: Colors.grey,
        elevation: 30),
    textTheme: TextTheme(
        bodyText1: TextStyle(
            fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white),subtitle1: TextStyle(
        fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white)),
    fontFamily: 'Schyler',
    scaffoldBackgroundColor: HexColor('#033E3E'));
ThemeData lightTheme = ThemeData(
    primarySwatch: defaultcolor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: defaultcolor,
    ),
    appBarTheme: AppBarTheme(
        titleSpacing: 20,
        backgroundColor: Colors.white,
        backwardsCompatibility: false,
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarBrightness: Brightness.dark),
        titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
        iconTheme: IconThemeData(color: Colors.black)),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: defaultcolor,
        unselectedItemColor: Colors.grey,
        elevation: 30),
    textTheme: TextTheme(
        bodyText1: TextStyle(
            fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black),
        subtitle1: TextStyle(
            fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black),
      subtitle2: TextStyle(
          fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
    ),
    fontFamily: 'Schyler',
    scaffoldBackgroundColor: Colors.white);
