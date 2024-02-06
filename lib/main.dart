import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/config/hive.dart';
import 'package:kira_dashboard/config/theme/app_theme.dart';
import 'package:kira_dashboard/config/theme/button_styles.dart';
import 'package:kira_dashboard/utils/router/router.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  await Hive.initFlutter();
  await initHive();

  initLocator();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppTheme appTheme = AppTheme();
  final AppRouter appRouter = AppRouter(navigatorKey: navigatorKey);

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: appTheme.getTheme(context),
      routerConfig: appRouter.config(),
    );
  }
}
