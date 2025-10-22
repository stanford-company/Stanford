import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';

enum AppTheme { LightTheme, DarkTheme }

final appThemeData = {
  AppTheme.LightTheme: ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    platform: TargetPlatform.iOS,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(primary: kColorPrimary),
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.white,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      iconTheme: IconThemeData(color: kColorPrimary),
      actionsIconTheme: IconThemeData(color: kColorPrimary),
      titleTextStyle: GoogleFonts.almarai(
        color: kColorDarkBlue,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
    dividerTheme: DividerThemeData(
      color: Colors.grey[300],
      thickness: 0.5,
      space: 0.5,
      indent: 10,
      endIndent: 10,
    ),
    textTheme: GoogleFonts.almaraiTextTheme(
      TextTheme(
        labelLarge: kTextStyleButton,
        titleMedium: kTextStyleSubtitle1.copyWith(color: kColorPrimaryDark),
        titleSmall: kTextStyleSubtitle2.copyWith(color: kColorPrimaryDark),
        bodyMedium: kTextStyleBody2.copyWith(color: kColorPrimaryDark),
        titleLarge: kTextStyleHeadline6.copyWith(color: kColorPrimaryDark),
      ),
    ),
    iconTheme: const IconThemeData(color: kColorPrimary),
    fontFamily: GoogleFonts.almarai().fontFamily,
    cardTheme: CardThemeData(
      elevation: 0,
      color: Color(0xffEBF2F5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
    ),
  ),
  AppTheme.DarkTheme: ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    platform: TargetPlatform.iOS,
    scaffoldBackgroundColor: Colors.black,
    colorScheme: const ColorScheme.dark(primary: kColorPrimary),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xff121212),
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: kColorDark,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      iconTheme: IconThemeData(color: kColorPrimary),
      actionsIconTheme: IconThemeData(color: kColorPrimary),
      titleTextStyle: GoogleFonts.almarai(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: Colors.white54,
      thickness: 0.5,
      space: 0.5,
      indent: 10,
      endIndent: 10,
    ),
    textTheme: GoogleFonts.almaraiTextTheme(
      TextTheme(
        labelLarge: kTextStyleButton,
        titleMedium: kTextStyleSubtitle1.copyWith(
          color: Colors.white.withOpacity(0.87),
        ),
        titleSmall: kTextStyleSubtitle2.copyWith(
          color: Colors.white.withOpacity(0.87),
        ),
        bodyMedium: kTextStyleBody2.copyWith(
          color: Colors.white.withOpacity(0.87),
        ),
        titleLarge: kTextStyleHeadline6.copyWith(
          color: Colors.white.withOpacity(0.87),
        ),
      ),
    ),
    iconTheme: IconThemeData(color: Colors.white.withOpacity(0.87)),
    fontFamily: GoogleFonts.almarai().fontFamily,
    cardTheme: CardThemeData(
      elevation: 0,
      color: kColorDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
        side: const BorderSide(width: 0, color: Colors.transparent),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white.withOpacity(0.87)),
      ),
    ),
  ),
};
