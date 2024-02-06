import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kira_dashboard/config/theme/button_styles.dart';

class AppTheme {
  ThemeData getTheme(BuildContext context) {
    ThemeData baseTheme = ThemeData.dark();
    baseTheme = baseTheme.copyWith(
      textTheme: GoogleFonts.robotoTextTheme(baseTheme.textTheme),
    );

    double windowWidth = MediaQuery.of(context).size.width;
    double fontSizeCofactor = windowWidth < 900 ? 0.9 : 1;

    return baseTheme.copyWith(
      scaffoldBackgroundColor: const Color(0xff06070a),
      colorScheme: const ColorScheme.dark(
        primary: Color(0xff4888f0),
        secondary: Color(0xff6c86ad),
        surface: Color(0xff06070a),
        background: Color(0xff06070a),
        onPrimary: Color(0xfffbfbfb),
        onSecondary: Color(0xfffbfbfb),
        onSurface: Color(0xfffbfbfb),
        onBackground: Color(0xfffbfbfb),
      ),
      textSelectionTheme: TextSelectionThemeData(selectionColor: Colors.white.withOpacity(0.2)),
      textButtonTheme: TextButtonThemeData(style: darkTextButtonStyle),
      elevatedButtonTheme: ElevatedButtonThemeData(style: darkElevatedButton),
      outlinedButtonTheme: OutlinedButtonThemeData(style: outlinedElevatedButton),
      textTheme: baseTheme.textTheme.copyWith(
        headlineLarge: baseTheme.textTheme.headlineLarge!.copyWith(fontSize: 32 * fontSizeCofactor),
        titleLarge: baseTheme.textTheme.titleLarge!.copyWith(fontSize: 16 * fontSizeCofactor),
        bodyLarge: baseTheme.textTheme.bodyLarge!.copyWith(fontSize: 20 * fontSizeCofactor),
        labelLarge: baseTheme.textTheme.labelLarge!.copyWith(fontSize: 13 * fontSizeCofactor),
        headlineMedium: baseTheme.textTheme.headlineMedium!.copyWith(fontSize: 24 * fontSizeCofactor),
        titleMedium: baseTheme.textTheme.titleMedium!.copyWith(fontSize: 20 * fontSizeCofactor),
        bodyMedium: baseTheme.textTheme.bodyMedium!.copyWith(fontSize: 14 * fontSizeCofactor),
        labelMedium: baseTheme.textTheme.labelMedium!.copyWith(fontSize: 12 * fontSizeCofactor),
        headlineSmall: baseTheme.textTheme.headlineSmall!.copyWith(fontSize: 20 * fontSizeCofactor),
        titleSmall: baseTheme.textTheme.titleSmall!.copyWith(fontSize: 16 * fontSizeCofactor),
        bodySmall: baseTheme.textTheme.bodySmall!.copyWith(fontSize: 13 * fontSizeCofactor),
        labelSmall: baseTheme.textTheme.labelSmall!.copyWith(fontSize: 12 * fontSizeCofactor),
      ),
    );
  }
}
