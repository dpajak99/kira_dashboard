import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kira_dashboard/config/app_icons.dart';
import 'package:kira_dashboard/models/coin.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_route.dart';
import 'package:kira_dashboard/pages/dialogs/send_tokens_dialog/send_tokens_dialog.dart';
import 'package:kira_dashboard/pages/portfolio_page/portfolio_page_state.dart';
import 'package:kira_dashboard/widgets/address_text.dart';
import 'package:kira_dashboard/widgets/coin_text.dart';
import 'package:kira_dashboard/widgets/custom_card.dart';
import 'package:kira_dashboard/widgets/custom_table.dart';
import 'package:kira_dashboard/widgets/token_icon.dart';

class BalancesPage extends StatelessWidget {
  final PortfolioPageState state;

  const BalancesPage({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      title: 'Tokens',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTable<Coin>(
            items: state.balance.length > 15 ? state.balance.sublist(0, 15) : state.balance,
            columns: <ColumnConfig<Coin>>[
              ColumnConfig(
                title: 'Token',
                cellBuilder: (BuildContext context, Coin item) {
                  return Row(
                    children: <Widget>[
                      TokenIcon(size: 24, iconUrl: item.icon),
                      const SizedBox(width: 12),
                      Expanded(child: Text(item.name, maxLines: 1, style: const TextStyle(fontSize: 14, color: Color(0xfffbfbfb)))),
                    ],
                  );
                },
              ),
              ColumnConfig(
                title: 'Type',
                cellBuilder: (BuildContext context, Coin item) {
                  return _TokenTypeChip(item.type);
                },
              ),
              ColumnConfig(
                title: 'Balance',
                flex: 2,
                textAlign: TextAlign.right,
                cellBuilder: (BuildContext context, Coin item) {
                  return CoinText(
                    coin: item,
                    style: const TextStyle(fontSize: 14, color: Color(0xfffbfbfb)),
                    textAlign: TextAlign.right,
                  );
                },
              ),
              if (state.isMyWallet)
              ColumnConfig(
                title: 'Actions',
                textAlign: TextAlign.right,
                cellBuilder: (BuildContext context, Coin item) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconTextButton(
                        text: 'Send',
                        gap: 4,
                        icon: AppIcons.arrow_up_right,
                        highlightColor: const Color(0xfffbfbfb),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xff4888f0),
                        ),
                        onTap: () => showDialog(
                          context: context,
                          builder: (BuildContext context) => CustomDialogRoute(content: SendTokensDialog(initialCoin: item)),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TokenTypeChip extends StatelessWidget {
  final CoinType type;

  const _TokenTypeChip(this.type);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: switch (type) {
            CoinType.token => const Color(0xff263042),
            CoinType.native => const Color(0x292f8af5),
            CoinType.derivative => const Color(0x292f8af5),
          },
        ),
        child: Text(
          '${type.name[0].toUpperCase()}${type.name.substring(1)}',
          style: TextStyle(
            fontSize: 12,
            color: switch (type) {
              CoinType.token => const Color(0xff6c86ad),
              CoinType.native => const Color(0xff2f8af5),
              CoinType.derivative => const Color(0xff2f8af5),
            },
          ),
        ),
      ),
    );
  }
}
