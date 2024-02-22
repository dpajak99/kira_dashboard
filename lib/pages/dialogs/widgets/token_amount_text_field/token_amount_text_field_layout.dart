import 'package:flutter/material.dart';
import 'package:kira_dashboard/config/theme/app_colors.dart';

class TokenAmountTextFieldLayout extends StatelessWidget {
  final Widget balanceWidget;
  final Widget tokenWidget;
  final Widget amountWidget;
  final Widget? footerWidget;

  const TokenAmountTextFieldLayout({
    super.key,
    required this.balanceWidget,
    required this.tokenWidget,
    required this.amountWidget,
    this.footerWidget,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: appColors.surface,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Asset',
                  style: textTheme.labelLarge!.copyWith(color: appColors.secondary),
                ),
                const Spacer(),
                balanceWidget,
              ],
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: tokenWidget,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: amountWidget,
                ),
              ),
            ],
          ),
          if (footerWidget != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: footerWidget,
            ),
        ],
      ),
    );
  }
}
