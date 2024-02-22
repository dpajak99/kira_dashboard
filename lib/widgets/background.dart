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
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: <double>[0.0, 0.3, 0.6, 1],
          colors: <Color>[
            Color(0xff0e121a),
            Color(0xff06070a),
            Color(0xff06070a),
            Color(0xff0e121a),
          ],
        ),
      ),
      child: child,
    );
  }
}