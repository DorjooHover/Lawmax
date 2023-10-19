// ignore_for_file: avoid_classes_with_only_static_members, avoid_redundant_argument_values, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:lawmax/global/global.dart';

import './text_theme.dart';

import 'package:google_fonts/google_fonts.dart';

class MyTheme {

  static ThemeData light = ThemeData(
    primaryColor: primary,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: secondary,
    ),
    navigationBarTheme: const NavigationBarThemeData(
      indicatorColor: Colors.transparent,
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      elevation: 8.0,
    ),
    textTheme: GoogleFonts.nunitoSansTextTheme(
      const TextTheme(
          titleMedium: mediumTitle,
          titleLarge: largeTitle,
          bodySmall: smallBody,
          displaySmall: smallDisplay,
          displayMedium: mediumDisplay,
          labelMedium: mediumLabel,
          labelSmall: smallLabel,
          bodyLarge: mediumBody),
    ),
    tabBarTheme: TabBarTheme(
      labelColor: secondary,
      unselectedLabelColor: Colors.black,
      overlayColor: MaterialStateProperty.all(Colors.white),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
    ),
    switchTheme: SwitchThemeData(
      trackColor: MaterialStateProperty.all(secondary),
      thumbColor: MaterialStateProperty.all(primary),
    ),
    cardTheme: const CardTheme(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      elevation: 2.0,
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed)) return primary;
          return null; // Use the component's default.
        },
      ),
    ),
  );
}
