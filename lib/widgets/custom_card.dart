import 'package:flutter/cupertino.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final Widget? leading;
  final String? title;
  final EdgeInsets? padding;
  final EdgeInsets? childPadding;

  const CustomCard({
    super.key,
    required this.child,
    this.leading,
    this.title,
    this.padding,
    this.childPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.symmetric(vertical: 24),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xff141924),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                if (title != null) ...<Widget>[
                  Text(title!, style: const TextStyle(fontSize: 24, color: Color(0xfffbfbfb))),
                ],
                if (leading != null) ...<Widget>[
                  Expanded(child: leading!),
                ],
              ],
            ),
          ),
          if (title != null || leading != null) const SizedBox(height: 24),
          Container(
            width: double.infinity,
            padding: childPadding ?? const EdgeInsets.symmetric(horizontal: 24),
            child: child,
          ),
        ],
      ),
    );
  }
}
