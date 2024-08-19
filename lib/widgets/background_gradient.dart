import 'package:flutter/cupertino.dart';
import 'package:kira_dashboard/config/theme/app_colors.dart';

class BackgroundGradient extends StatelessWidget {
  final Widget child;

  const BackgroundGradient({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        color: CustomColors.background,
      ),
      child: child,
    );
  }
}