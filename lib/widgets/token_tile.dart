import 'package:flutter/material.dart';
import 'package:kira_dashboard/config/theme/app_colors.dart';
import 'package:kira_dashboard/models/coin.dart';
import 'package:kira_dashboard/widgets/token_icon.dart';

class TokenTile extends StatelessWidget {
  final Coin? coin;
  final bool reversed;
  final bool showAmount;

  const TokenTile({
    super.key,
    required this.coin,
    this.reversed = false,
    this.showAmount = false,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    if (coin == null) {
      return Padding(
        padding: EdgeInsets.only(right: reversed ? 0 : 32, left: reversed ? 32 : 0),
        child: Text(
          '---',
          style: textTheme.bodyMedium!.copyWith(color: appColors.onBackground),
        ),
      );
    }

    if (reversed) {
      return Row(
        children: <Widget>[
          Expanded(
            child: Text(
              showAmount ? coin!.toNetworkDenominationString() : coin!.name,
              maxLines: 1,
              textAlign: TextAlign.right,
              style: textTheme.bodyMedium!.copyWith(color: appColors.onBackground),
            ),
          ),
          const SizedBox(width: 12),
          TokenIcon(size: 24, iconUrl: coin!.icon),
        ],
      );
    }

    return Row(
      children: <Widget>[
        TokenIcon(size: 24, iconUrl: coin!.icon),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            showAmount ? coin!.toNetworkDenominationString() : coin!.name,
            maxLines: 1,
            style: textTheme.bodyMedium!.copyWith(color: appColors.onBackground),
          ),
        ),
      ],
    );
  }
}
