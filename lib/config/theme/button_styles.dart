import 'package:flutter/material.dart';

ButtonStyle textButtonStyle = TextButton.styleFrom(
  foregroundColor: const Color(0xff6c86ad),
  textStyle: const TextStyle(fontSize: 16),
);

ButtonStyle outlinedElevatedButton = OutlinedButton.styleFrom(
  textStyle: const TextStyle(fontSize: 16),
  foregroundColor: const Color(0xff6c86ad),
  side: const BorderSide(
    width: 1.0,
    color: Color(0xff6c86ad),
  ),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(16)),
  ),
);

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
