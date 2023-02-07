import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_colors.dart';

class CustomTheme {
  static const MaterialColor appPrimaryRed =
      MaterialColor(_primaryRed, <int, Color>{
    50: Color(0xFFF5E2E3),
    100: Color(0xFFE7B6B8),
    200: Color(0xFFD78689),
    300: Color(0xFFC65659),
    400: Color(0xFFBA3136),
    500: Color(_primaryRed),
    600: Color(0xFFA70B10),
    700: Color(0xFF9D090D),
    800: Color(0xFF94070A),
    900: Color(0xFF840305),
  });
  static const int _primaryRed = 0xFFAE0D12;

  static const MaterialColor appAccentRed =
      MaterialColor(_appAccentRed, <int, Color>{
    100: Color(0xFFFFB1B2),
    200: Color(_appAccentRed),
    400: Color(0xFFFF4B4D),
    700: Color(0xFFFF3133),
  });
  static const int _appAccentRed = 0xFFFF7E7F;

  static const MaterialColor appPrimaryGrey =
      MaterialColor(_appPrimaryGrey, <int, Color>{
    50: Color(0xFFF0F0F0),
    100: Color(0xFFD9D9DA),
    200: Color(0xFFBFC0C2),
    300: Color(0xFFA5A6A9),
    400: Color(0xFF929396),
    500: Color(_appPrimaryGrey),
    600: Color(0xFF77787C),
    700: Color(0xFF6C6D71),
    800: Color(0xFF626367),
    900: Color(0xFF4F5054),
  });
  static const int _appPrimaryGrey = 0xFF7F8084;

  static const MaterialColor appPrimaryGrey2 =
      MaterialColor(_appPrimaryGrey2, <int, Color>{
    50: Color(0xFFF0F0F0),
    100: Color(0xFFD9D9DA),
    200: Color(0xFFBFC0C2),
    300: Color(0xFFA5A6A9),
    400: Color(0xFF929396),
    500: Color(_appPrimaryGrey2),
    600: Color(0xFF77787C),
    700: Color(0xFF6C6D71),
    800: Color(0xFF626367),
    900: Color(0xFF4F5054),
  });
  static const int _appPrimaryGrey2 = 0xFF191819;

  static const MaterialColor appAccentGrey =
      MaterialColor(_appAccentGrey, <int, Color>{
    100: Color(0xFFC1CDFA),
    200: Color(_appAccentGrey),
    400: Color(0xFF5678FF),
    700: Color(0xFF3C63FF),
  });
  static const int _appAccentGrey = 0xFF92A6F5;

  static final lightTheme = ThemeData.from(
    colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.onPrimary,
        onPrimary: CustomTheme.appAccentGrey,
        primaryContainer: CustomTheme.appPrimaryGrey2.shade300,
        secondary: CustomTheme.appPrimaryRed,
        onSecondary: CustomTheme.appAccentRed,
        secondaryContainer: CustomTheme.appPrimaryRed.shade300,
        tertiary: Colors.yellow,
        error: Colors.red,
        onError: Colors.white,
        background: Colors.white70,
        onBackground: Colors.white70,
        surface: AppColors.onPrimary,
        onSurface: Colors.white),
    textTheme: TextTheme(
      bodySmall: GoogleFonts.dmSans(fontSize: 11),
      bodyMedium: GoogleFonts.dmSans(fontSize: 13),
      bodyLarge: GoogleFonts.dmSans(fontSize: 16),
      titleSmall: GoogleFonts.dmSans(
        fontSize: 18,
      ),
      titleMedium:
          GoogleFonts.dmSans(fontSize: 15, fontWeight: FontWeight.w800),
      titleLarge: GoogleFonts.dmSans(fontSize: 20, fontWeight: FontWeight.w900),
      // dmSans
    ),
  ).copyWith(
      primaryColorLight: CustomTheme.appAccentRed,
      primaryColorDark: CustomTheme.appPrimaryRed,
      appBarTheme: AppBarTheme(
          actionsIconTheme: IconThemeData(color: CustomTheme.appPrimaryRed)),
      bottomAppBarTheme:
          BottomAppBarTheme(color: CustomTheme.appPrimaryGrey2.shade300));

  static final darkTheme = ThemeData.from(
    colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: AppColors.onPrimary,
        onPrimary: CustomTheme.appAccentGrey,
        primaryContainer: CustomTheme.appPrimaryGrey2.shade300,
        secondary: CustomTheme.appPrimaryRed,
        onSecondary: CustomTheme.appAccentRed,
        secondaryContainer: CustomTheme.appPrimaryRed.shade300,
        tertiary: Colors.yellow,
        error: Colors.red,
        onError: Colors.white,
        background: AppColors.primary,
        onBackground: Colors.white70,
        surface: AppColors.onPrimary,
        onSurface: Colors.white),
    textTheme: TextTheme(
      bodySmall: GoogleFonts.dmSans(fontSize: 11),
      bodyMedium: GoogleFonts.dmSans(fontSize: 13),
      bodyLarge: GoogleFonts.dmSans(fontSize: 16),
      titleSmall: GoogleFonts.dmSans(
        fontSize: 18,
      ),
      titleMedium:
          GoogleFonts.dmSans(fontSize: 15, fontWeight: FontWeight.w800),
      titleLarge: GoogleFonts.dmSans(fontSize: 20, fontWeight: FontWeight.w900),
      // dmSans
    ),
  ).copyWith(
      primaryColorLight: CustomTheme.appAccentRed,
      primaryColorDark: CustomTheme.appPrimaryRed,
      appBarTheme: AppBarTheme(
          actionsIconTheme: IconThemeData(color: CustomTheme.appPrimaryRed)),
      bottomAppBarTheme:
          BottomAppBarTheme(color: CustomTheme.appPrimaryGrey2.shade300));
}
