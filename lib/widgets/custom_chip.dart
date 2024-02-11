import 'package:flutter/cupertino.dart';

class CustomChip extends StatelessWidget {
  final Text child;

  const CustomChip({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: child.style?.color?.withOpacity(0.3),
        ),
        child: child,
      ),
    );
  }
}
