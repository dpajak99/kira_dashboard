import 'package:flutter/material.dart';

class MobileRow extends StatelessWidget {
  final Widget title;
  final Widget value;

  const MobileRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: title,
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 2,
          child: value,
        ),
      ],
    );
  }
}
