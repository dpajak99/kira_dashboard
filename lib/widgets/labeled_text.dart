import 'package:flutter/material.dart';
import 'package:kira_dashboard/config/theme/app_colors.dart';

class LabeledText extends StatelessWidget {
  final String label;
  final String text;

  const LabeledText({
    super.key,
    required this.label,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: textTheme.bodyMedium!.copyWith(color: CustomColors.secondary),
        ),
        Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: textTheme.bodyMedium!.copyWith(color: CustomColors.white),
        ),
      ],
    );
  }
}