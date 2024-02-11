import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final Widget? leading;
  final String? title;
  final EdgeInsets? padding;
  final EdgeInsets? childPadding;
  final bool enableMobile;
  final double titleSpacing;
  final TextStyle? titleStyle;

  const CustomCard({
    super.key,
    required this.child,
    this.leading,
    this.title,
    this.titleStyle,
    this.titleSpacing = 24,
    this.padding,
    this.childPadding,
    this.enableMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    Widget titleWidget = Row(
      children: [
        if (title != null) ...<Widget>[
          Text(title!, style: titleStyle ?? textTheme.headlineMedium!.copyWith(color: const Color(0xfffbfbfb))),
        ],
        if (leading != null) ...<Widget>[
          Expanded(
            child: Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: leading!),
          ),
        ],
      ],
    );

    Widget childWidget = child;

    if (!enableMobile || (enableMobile && MediaQuery.of(context).size.width >= 900)) {
      titleWidget = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: titleWidget,
      );

      childWidget = Container(
        width: double.infinity,
        padding: childPadding ?? const EdgeInsets.symmetric(horizontal: 24),
        child: child,
      );
    }

    Widget content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleWidget,
        if (title != null || leading != null) SizedBox(height: titleSpacing),
        childWidget,
      ],
    );

    if (enableMobile && MediaQuery.of(context).size.width < 900) {
      return content;
    }
    return Container(
      padding: padding ?? const EdgeInsets.symmetric(vertical: 24),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(0x88141924),
      ),
      child: content,
    );
  }
}
