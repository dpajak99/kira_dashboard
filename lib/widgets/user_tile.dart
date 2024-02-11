import 'package:flutter/material.dart';
import 'package:kira_dashboard/widgets/address_text.dart';
import 'package:kira_dashboard/widgets/avatar/identity_avatar.dart';

class UserTile extends StatelessWidget {
  final String address;

  const UserTile({
    super.key,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Row(
      children: <Widget>[
        IdentityAvatar(size: 32, address: address),
        const SizedBox(width: 12),
        Expanded(
          child: CopyableAddressText(
            address: address,
            style: textTheme.bodyMedium!.copyWith(color: const Color(0xff2f8af5)),
          ),
        ),
      ],
    );
  }
}
