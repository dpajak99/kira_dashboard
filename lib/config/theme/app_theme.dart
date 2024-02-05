import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kira_dashboard/config/theme/button_styles.dart';

class AppTheme {
  ThemeData get theme {
    ThemeData baseTheme = ThemeData.dark();
    baseTheme = baseTheme.copyWith(
      textTheme: GoogleFonts.robotoTextTheme(baseTheme.textTheme),
    );

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
      textButtonTheme: TextButtonThemeData(style: textButtonStyle),
      elevatedButtonTheme: ElevatedButtonThemeData(style: darkElevatedButton),
      outlinedButtonTheme: OutlinedButtonThemeData(style: outlinedElevatedButton),
      textTheme: baseTheme.textTheme.copyWith(
        bodyLarge: baseTheme.textTheme.bodyLarge!.copyWith(fontSize: 14),
        bodyMedium: baseTheme.textTheme.bodyMedium!.copyWith(fontSize: 14),
        bodySmall: baseTheme.textTheme.bodySmall!.copyWith(fontSize: 14),
        labelLarge: baseTheme.textTheme.labelLarge!.copyWith(fontSize: 13),
        labelMedium: baseTheme.textTheme.labelMedium!.copyWith(fontSize: 12),
        labelSmall: baseTheme.textTheme.labelSmall!.copyWith(fontSize: 12),
      ),
    );
  }
}
