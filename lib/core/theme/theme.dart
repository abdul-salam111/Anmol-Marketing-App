import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.appLightThemeBackground,
    brightness: Brightness.light,
    primaryColor: AppColors.appPrimaryColor,
    cardColor: AppColors.appLightThemeBackground,
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Colors.blue,
    ),
    textTheme: TextTheme(
      headlineLarge: GoogleFonts.ubuntu(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headlineMedium: GoogleFonts.ubuntu(
        fontSize: 25.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headlineSmall: GoogleFonts.ubuntu(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      bodyLarge: GoogleFonts.ubuntu(fontSize: 18.0, color: Colors.black),
      bodyMedium: GoogleFonts.inter(fontSize: 16.0, color: Colors.black),
      bodySmall: GoogleFonts.inter(fontSize: 14.0, color: Colors.black),
      displayLarge: GoogleFonts.inter(fontSize: 12.0, color: Colors.black),
      displayMedium: GoogleFonts.inter(fontSize: 10.0, color: Colors.black),
      displaySmall: GoogleFonts.inter(fontSize: 8.0, color: Colors.black),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.appDarkThemeBackground,
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Colors.grey,
    ),
    brightness: Brightness.dark,
    primaryColor: AppColors.appPrimaryColor,
    cardColor: AppColors.appDarkThemeBackground,
    textTheme: TextTheme(
      headlineLarge: GoogleFonts.ubuntu(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      headlineMedium: GoogleFonts.ubuntu(
        fontSize: 25.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      headlineSmall: GoogleFonts.ubuntu(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      bodyLarge: GoogleFonts.ubuntu(fontSize: 18.0, color: Colors.white70),
      bodyMedium: GoogleFonts.inter(fontSize: 16.0, color: Colors.white70),
      bodySmall: GoogleFonts.inter(fontSize: 14.0, color: Colors.white70),
      displayLarge: GoogleFonts.inter(fontSize: 12.0, color: Colors.white70),
      displayMedium: GoogleFonts.inter(fontSize: 10.0, color: Colors.white70),
      displaySmall: GoogleFonts.inter(fontSize: 8.0, color: Colors.white70),
    ),
  );
}
