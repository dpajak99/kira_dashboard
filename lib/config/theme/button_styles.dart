import 'package:flutter/material.dart';
import 'package:kira_dashboard/config/theme/app_colors.dart';

ButtonStyle darkTextButtonStyle = TextButton.styleFrom(
  foregroundColor: CustomColors.secondary,
  textStyle: const TextStyle(fontSize: 16, color: CustomColors.secondary),
);

ButtonStyle lightTextButtonStyle = TextButton.styleFrom(
  foregroundColor: CustomColors.primary,
  textStyle: const TextStyle(fontSize: 16, color: CustomColors.primary),
);

ButtonStyle signupButtonStyle = ButtonStyle(
  alignment: Alignment.centerLeft,
  animationDuration: Duration.zero,
  overlayColor: WidgetStateProperty.all(Colors.transparent),
  backgroundColor: WidgetStateProperty.all(CustomColors.dialogContainer),
  foregroundColor: WidgetStateProperty.resolveWith(
    (Set<WidgetState> states) => states.contains(WidgetState.hovered) ? CustomColors.primary : CustomColors.white,
  ),
  shape: WidgetStateProperty.resolveWith(
    (Set<WidgetState> states) => RoundedRectangleBorder(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      side: BorderSide(
        color: states.contains(WidgetState.hovered) ? const Color(0xff2f3b4d) : const Color(0xff06070a),
      ),
    ),
  ),
);

ButtonStyle outlinedElevatedButton = OutlinedButton.styleFrom(
  textStyle: const TextStyle(fontSize: 16),
  foregroundColor: CustomColors.secondary,
  side: const BorderSide(
    width: 1.0,
    color: CustomColors.secondary,
  ),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(16)),
  ),
);

ButtonStyle darkElevatedButton = ElevatedButton.styleFrom(
  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
  animationDuration: Duration.zero,
  backgroundColor: CustomColors.primary,
  disabledBackgroundColor: const Color(0xff354053),
  foregroundColor: CustomColors.white,
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
  foregroundColor: CustomColors.primary,
  disabledForegroundColor: const Color(0xff7185ab),
  textStyle: const TextStyle(fontSize: 16, color: CustomColors.primary),
  padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 16),
  minimumSize: const Size(100, 50),
);

ButtonStyle filledIconButton = IconButton.styleFrom(
  backgroundColor: CustomColors.primary,
);
