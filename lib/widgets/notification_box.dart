import 'package:flutter/material.dart';
import 'package:kira_dashboard/config/app_icons.dart';
import 'package:kira_dashboard/config/theme/app_colors.dart';

enum NotificationType {
  success,
  error,
  warning,
}

class NotificationBox extends StatelessWidget {
  final String message;
  final NotificationType type;

  const NotificationBox({
    super.key,
    required this.message,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    Color color = switch (type) {
      NotificationType.success => CustomColors.green,
      NotificationType.error => CustomColors.red,
      NotificationType.warning => CustomColors.yellow,
    };

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Icon(
            switch (type) {
              NotificationType.success => AppIcons.checkbox_circle,
              NotificationType.error => AppIcons.error,
              NotificationType.warning => AppIcons.alert_circle,
            },
            color: color.withOpacity(0.8),
            size: 16,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: textTheme.labelMedium!.copyWith(
                color: color.withOpacity(0.8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
