import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/utils/router/router.dart';

void main() {
  initLocator();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData baseTheme = ThemeData(brightness: Brightness.dark);
    ThemeData theme = baseTheme.copyWith(
      textTheme: GoogleFonts.robotoTextTheme(baseTheme.textTheme),
    );

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: theme.copyWith(
        scaffoldBackgroundColor: const Color(0xff06070a),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xff06070a),
          secondary: Color(0xff06070a),
          surface: Color(0xff06070a),
          background: Color(0xff06070a),
          onPrimary: Color(0xfffbfbfb),
          onSecondary: Color(0xfffbfbfb),
          onSurface: Color(0xfffbfbfb),
          onBackground: Color(0xfffbfbfb),
        ),
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: Colors.white.withOpacity(0.2),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xff6c86ad),
            textStyle: const TextStyle(fontSize: 16),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
            backgroundColor: const Color(0xff2f8af5),
            foregroundColor: const Color(0xfffbfbfb),
            textStyle: const TextStyle(fontSize: 16, color: Color(0xfffbfbfb)),
            padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 16),
            minimumSize: const Size(100, 50),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.transparent),
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
            backgroundColor: const Color(0xff182a44),
            foregroundColor: const Color(0xff2f8af5),
            textStyle: const TextStyle(fontSize: 16, color: Color(0xff2f8af5)),
            padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 16),
            minimumSize: const Size(100, 50),
          ),
        ),
      ),
      routerConfig: _appRouter.config(),
    );
  }
}
