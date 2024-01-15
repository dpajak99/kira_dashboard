import 'package:flutter/material.dart';
import 'package:kira_dashboard/utils/router/router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
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
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xff6c86ad),
            textStyle: const TextStyle(fontSize: 16),
          ),
        ),
      ),
      routerConfig: _appRouter.config(),
    );
  }
}
