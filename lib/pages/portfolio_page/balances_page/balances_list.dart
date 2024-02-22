import 'package:flutter/material.dart';
import 'package:kira_dashboard/config/app_icons.dart';
import 'package:kira_dashboard/config/theme/app_colors.dart';
import 'package:kira_dashboard/models/coin.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_route.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/send_tokens_dialog/send_tokens_dialog.dart';
import 'package:kira_dashboard/pages/portfolio_page/balances_page/balances_list_cubit.dart';
import 'package:kira_dashboard/widgets/address_text.dart';
import 'package:kira_dashboard/widgets/coin_text.dart';
import 'package:kira_dashboard/widgets/custom_chip.dart';
import 'package:kira_dashboard/widgets/custom_table.dart';
import 'package:kira_dashboard/widgets/custom_table_paginated.dart';
import 'package:kira_dashboard/widgets/sized_shimmer.dart';
import 'package:kira_dashboard/widgets/token_tile.dart';

class BalancesList extends StatelessWidget {
  final bool isMyWallet;
  final BalancesListCubit cubit;

  const BalancesList({
    super.key,
    required this.isMyWallet,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return CustomTablePaginated<Coin>(
      cubit: cubit,
      mobileBuilder: (BuildContext context, Coin? item, bool loading) {
        if (item == null || loading) {
          return const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedShimmer(width: double.infinity, height: 24),
              SizedBox(height: 8),
              SizedShimmer(width: double.infinity, height: 24),
            ],
          );
        }
        return _MobileListTile(
          coin: item,
          isMyWallet: isMyWallet,
          onSend: () => _handleSend(item),
        );
      },
      columns: <ColumnConfig<Coin>>[
        ColumnConfig(
          title: 'Token',
          cellBuilder: (BuildContext context, Coin item) {
            return TokenTile(coin: item);
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
              style: textTheme.bodyMedium!.copyWith(color: CustomColors.white),
              textAlign: TextAlign.right,
            );
          },
        ),
        if (isMyWallet)
          ColumnConfig(
            title: 'Actions',
            textAlign: TextAlign.right,
            cellBuilder: (BuildContext context, Coin item) {
              return Align(
                alignment: Alignment.centerRight,
                child: SimpleTextButton(
                  text: 'Send',
                  gap: 4,
                  icon: AppIcons.arrow_up_right,
                  onTap: () => _handleSend(item),
                ),
              );
            },
          ),
      ],
    );
  }

  void _handleSend(Coin item) {
    DialogRouter().navigate(SendTokensDialog(initialCoin: item));
  }
}

class _MobileListTile extends StatelessWidget {
  final Coin coin;
  final bool isMyWallet;
  final VoidCallback onSend;

  const _MobileListTile({
    required this.coin,
    required this.isMyWallet,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  _TokenTypeChip(coin.type),
                  const SizedBox(height: 8),
                  TokenTile(coin: coin),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CoinText(
                    coin: coin,
                    style: textTheme.bodyMedium!.copyWith(color: CustomColors.white),
                    textAlign: TextAlign.right,
                  ),
                  if (isMyWallet) ...<Widget>[
                    const SizedBox(height: 4),
                    SimpleTextButton(
                      text: 'Send',
                      gap: 4,
                      reversed: true,
                      icon: AppIcons.arrow_up_right,
                      onTap: () => DialogRouter().navigate(SendTokensDialog(initialCoin: coin)),
                    ),
                  ],
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}

class _TokenTypeChip extends StatelessWidget {
  final CoinType type;

  const _TokenTypeChip(this.type);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return CustomChip(
      child: Text(
        '${type.name[0].toUpperCase()}${type.name.substring(1)}',
        style: textTheme.labelMedium!.copyWith(
          color: switch (type) {
            CoinType.token => CustomColors.secondary,
            CoinType.native => CustomColors.primary,
            CoinType.derivative => CustomColors.primary,
          },
        ),
      ),
    );
  }
}
