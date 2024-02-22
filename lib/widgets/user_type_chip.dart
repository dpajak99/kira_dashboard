import 'package:flutter/material.dart';
import 'package:kira_dashboard/config/theme/app_colors.dart';

enum UserType {
  validator,
  user,
  yourAccount,
}

class UserTypeChip extends StatelessWidget {
  final UserType userType;
  final Alignment alignment;

  const UserTypeChip({
    required this.userType,
    this.alignment = Alignment.centerLeft,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Align(
      alignment: alignment,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: switch (userType) {
            UserType.user => CustomColors.secondary,
            UserType.validator => CustomColors.primary,
            UserType.yourAccount => CustomColors.green,
          }.withOpacity(0.3),
        ),
        child: Text(
          switch (userType) {
            UserType.user => 'User',
            UserType.validator => 'Validator',
            UserType.yourAccount => 'Your account',
          },
          style: textTheme.labelLarge!.copyWith(
            color: switch (userType) {
              UserType.user => CustomColors.secondary,
              UserType.validator => CustomColors.primary,
              UserType.yourAccount => CustomColors.green,
            },
          ),
        ),
      ),
    );
  }
}
