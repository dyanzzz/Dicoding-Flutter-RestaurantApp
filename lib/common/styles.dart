import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final Color primaryColor = Color(0xFF232F34);
final Color secondaryColor = Color(0xFFF9AA33);

final TextTheme myTextTheme = TextTheme(
  headline1: GoogleFonts.comicNeue(
      fontSize: 102, fontWeight: FontWeight.w300, letterSpacing: -1.5),
  headline2: GoogleFonts.comicNeue(
      fontSize: 64, fontWeight: FontWeight.w300, letterSpacing: -0.5),
  headline3: GoogleFonts.comicNeue(fontSize: 51, fontWeight: FontWeight.w400),
  headline4: GoogleFonts.comicNeue(
      fontSize: 36, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headline5: GoogleFonts.comicNeue(fontSize: 25, fontWeight: FontWeight.w400),
  headline6: GoogleFonts.comicNeue(
      fontSize: 21, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  subtitle1: GoogleFonts.comicNeue(
      fontSize: 17, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  subtitle2: GoogleFonts.comicNeue(
      fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyText1: GoogleFonts.tenorSans(
      fontSize: 17, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  bodyText2: GoogleFonts.tenorSans(
      fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  button: GoogleFonts.tenorSans(
      fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  caption: GoogleFonts.tenorSans(
      fontSize: 13, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  overline: GoogleFonts.tenorSans(
      fontSize: 11, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);

ThemeData lightTheme = ThemeData(
  primaryColor: primaryColor,
  accentColor: secondaryColor,
  scaffoldBackgroundColor: Colors.white,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: myTextTheme,
  appBarTheme: AppBarTheme(
      textTheme: myTextTheme.apply(
        bodyColor: Colors.white,
      ),
      elevation: 0),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: secondaryColor,
      backgroundColor: primaryColor,
      unselectedItemColor: Colors.grey),
  buttonTheme: ButtonThemeData(
    buttonColor: secondaryColor,
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(0),
      ),
    ),
  ),
);
