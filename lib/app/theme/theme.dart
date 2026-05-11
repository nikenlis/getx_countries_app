import 'package:flutter/material.dart';
import 'app_color.dart';

class AppTheme {
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: background,
    hintColor: primary,
    scaffoldBackgroundColor: background,
    colorScheme: ColorScheme.dark(
      primary: primary,
      secondary: accent,
      surface: border,
      onPrimary: textPrimary,
      onSecondary: textSecondary,
      onSurface: textPrimary,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      iconTheme: IconThemeData(color: textPrimary, size: kIconSize),
      actionsIconTheme: IconThemeData(color: textPrimary, size: kIconSize),
      titleTextStyle: TextStyle(
        color: textPrimary,
        fontSize: 18,
        fontWeight: semiBold,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: textPrimary,
        minimumSize: Size(double.infinity, 48),
        textStyle: TextStyle(color: base, fontSize: 16, fontWeight: medium),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),
  );
}
