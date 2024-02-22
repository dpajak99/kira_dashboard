import 'package:flutter/material.dart';
import 'package:kira_dashboard/config/theme/app_colors.dart';

ButtonStyle darkTextButtonStyle = TextButton.styleFrom(
  foregroundColor: appColors.secondary,
  textStyle: TextStyle(fontSize: 16, color: appColors.secondary),
);

ButtonStyle lightTextButtonStyle = TextButton.styleFrom(
  foregroundColor: appColors.primary,
  textStyle: TextStyle(fontSize: 16, color: appColors.primary),
);

ButtonStyle signupButtonStyle = ButtonStyle(
  alignment: Alignment.centerLeft,
  animationDuration: Duration.zero,
  overlayColor: MaterialStateProperty.all(Colors.transparent),
  backgroundColor: MaterialStateProperty.all(appColors.surface),
  foregroundColor: MaterialStateProperty.resolveWith(
      (Set<MaterialState> states) => states.contains(MaterialState.hovered) ? appColors.primary : appColors.onBackground),
  shape: MaterialStateProperty.resolveWith(
    (Set<MaterialState> states) => RoundedRectangleBorder(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      side: BorderSide(
        color: states.contains(MaterialState.hovered) ? const Color(0xff2f3b4d) : appColors.surface,
      ),
    ),
  ),
);

ButtonStyle outlinedElevatedButton = OutlinedButton.styleFrom(
  textStyle: const TextStyle(fontSize: 16),
  foregroundColor: appColors.secondary,
  side: BorderSide(
    width: 1.0,
    color: appColors.secondary,
  ),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(16)),
  ),
);

ButtonStyle darkElevatedButton = ElevatedButton.styleFrom(
  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
  animationDuration: Duration.zero,
  backgroundColor: appColors.primary,
  disabledBackgroundColor: const Color(0xff354053),
  foregroundColor: appColors.onBackground,
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
  foregroundColor: appColors.primary,
  disabledForegroundColor: const Color(0xff7185ab),
  textStyle: TextStyle(fontSize: 16, color: appColors.primary),
  padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 16),
  minimumSize: const Size(100, 50),
);

ButtonStyle filledIconButton = IconButton.styleFrom(
  backgroundColor: appColors.primary,
);
