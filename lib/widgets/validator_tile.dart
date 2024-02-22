import 'package:flutter/material.dart';
import 'package:kira_dashboard/config/theme/app_colors.dart';
import 'package:kira_dashboard/widgets/address_text.dart';
import 'package:kira_dashboard/widgets/avatar/identity_avatar.dart';

class ValidatorTile extends StatelessWidget {
  final String moniker;
  final String address;

  const ValidatorTile({
    super.key,
    required this.moniker,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        IdentityAvatar(size: 32, address: address),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(moniker, style: textTheme.bodyMedium?.copyWith(color: CustomColors.white)),
              const SizedBox(height: 2),
              OpenableAddressText(address: address),
            ],
          ),
        ),
      ],
    );
  }
}
