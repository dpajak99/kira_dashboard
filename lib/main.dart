import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/config/hive.dart';
import 'package:kira_dashboard/utils/router/router.dart';

ButtonStyle darkElevatedButton = ElevatedButton.styleFrom(
  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
  animationDuration: Duration.zero,
  backgroundColor: const Color(0xff2f8af5),
  disabledBackgroundColor: const Color(0xff354053),
  foregroundColor: const Color(0xfffbfbfb),
  disabledForegroundColor: const Color(0xff7185ab),
  textStyle: const TextStyle(fontSize: 16, color: Color(0xfffbfbfb)),
  padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 16),
  minimumSize: const Size(100, 50),
);

ButtonStyle lightElevatedButton = ElevatedButton.styleFrom(
  side: const BorderSide(color: Colors.transparent),
  animationDuration: Duration.zero,
  backgroundColor: const Color(0xff182a44),
  disabledBackgroundColor: const Color(0xff354053),
  foregroundColor: const Color(0xff2f8af5),
  disabledForegroundColor: const Color(0xff7185ab),
  textStyle: const TextStyle(fontSize: 16, color: Color(0xff2f8af5)),
  padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 16),
  minimumSize: const Size(100, 50),
);

ButtonStyle filledIconButton = IconButton.styleFrom(
  backgroundColor: const Color(0xff4888f0),
);

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  await Hive.initFlutter();
  await initHive();

  initLocator();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter(navigatorKey: navigatorKey);

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData baseTheme = ThemeData.dark();
    ThemeData theme = baseTheme.copyWith(
      textTheme: GoogleFonts.robotoTextTheme(baseTheme.textTheme),
    );

    double densityAmt = false ? 0.0 : -1.0;
    VisualDensity density = VisualDensity(horizontal: densityAmt, vertical: densityAmt);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: theme.copyWith(
        visualDensity: density,
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
        elevatedButtonTheme: ElevatedButtonThemeData(style: darkElevatedButton),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            textStyle: const TextStyle(fontSize: 16),
            foregroundColor: const Color(0xff6c86ad),
            side: const BorderSide(
              width: 1.0,
              color: Color(0xff6c86ad),
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
          ),
        ),
      ),
      routerConfig: _appRouter.config(),
    );
  }
}
