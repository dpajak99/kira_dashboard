import 'package:flutter/cupertino.dart';
import 'package:kira_dashboard/config/theme/app_colors.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({super.key, required this.child});

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