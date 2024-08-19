import 'package:flutter/material.dart';
import 'package:kira_dashboard/config/theme/app_colors.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SliverCustomCard extends StatelessWidget {
  final Widget sliver;
  final Widget? leading;
  final String? title;
  final EdgeInsets? padding;
  final EdgeInsets? childPadding;
  final bool enableMobile;
  final double titleSpacing;
  final TextStyle? titleStyle;

  const SliverCustomCard({
    super.key,
    required this.sliver,
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
          Text(title!,
              style: titleStyle ??
                  textTheme.headlineMedium!
                      .copyWith(color: CustomColors.white)),
        ],
        if (leading != null) ...<Widget>[
          Expanded(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: leading!),
          ),
        ],
      ],
    );

    Widget childWidget = sliver;

    if (!enableMobile ||
        (enableMobile && MediaQuery.of(context).size.width >= 900)) {
      titleWidget = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: titleWidget,
      );

      childWidget = SliverPadding(
        padding: childPadding ?? const EdgeInsets.symmetric(horizontal: 24),
        sliver: sliver,
      );
    }

    Widget content = MultiSliver(
      children: [
        SliverToBoxAdapter(child: titleWidget),
        if (title != null || leading != null)
          SliverToBoxAdapter(child: SizedBox(height: titleSpacing)),
        childWidget,
      ],
    );

    if (enableMobile && MediaQuery.of(context).size.width < 900) {
      return content;
    }
    return DecoratedSliver(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: CustomColors.container,
      ),
      sliver: SliverPadding(
        padding: padding ?? const EdgeInsets.symmetric(vertical: 24),
        sliver: content,
      ),
    );
  }
}
