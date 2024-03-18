import 'package:flutter/material.dart';
import 'package:kira_dashboard/widgets/address_text.dart';
import 'package:kira_dashboard/widgets/avatar/identity_avatar.dart';

class UserTile extends StatelessWidget {
  final String address;
  final String? name;
  final String? avatar;

  const UserTile({
    super.key,
    required this.address,
    this.name,
    this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IdentityAvatar(size: 32, address: address, avatarUrl: avatar),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            children: [
              if (name != null)
                Text(
                  name!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
              CopyableAddressText(address: address),
            ],
          ),
        ),
      ],
    );
  }
}
