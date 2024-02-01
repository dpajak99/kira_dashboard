import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/config/app_icons.dart';
import 'package:kira_dashboard/models/coin.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_route.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/send_tokens_dialog/send_tokens_dialog.dart';
import 'package:kira_dashboard/pages/portfolio_page/balances_page/balances_list_cubit.dart';
import 'package:kira_dashboard/pages/portfolio_page/balances_page/balances_list_state.dart';
import 'package:kira_dashboard/widgets/address_text.dart';
import 'package:kira_dashboard/widgets/coin_text.dart';
import 'package:kira_dashboard/widgets/custom_card.dart';
import 'package:kira_dashboard/widgets/custom_table.dart';
import 'package:kira_dashboard/widgets/sized_shimmer.dart';
import 'package:kira_dashboard/widgets/token_icon.dart';

class BalancesPage extends StatefulWidget {
  final String address;
  final bool isMyWallet;

  const BalancesPage({
    super.key,
    required this.address,
    required this.isMyWallet,
  });

  @override
  State<StatefulWidget> createState() => _BalancesPageState();
}

class _BalancesPageState extends State<BalancesPage> {
  late final BalancesListCubit cubit = BalancesListCubit(
    address: widget.address,
    isMyWallet: widget.isMyWallet,
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: cubit,
      builder: (BuildContext context, BalancesListState state) {
        return CustomCard(
          title: 'Tokens',
          enableMobile: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTable<Coin>(
                pageSize: state.pageSize,
                loading: state.isLoading,
                items: state.balances.length > 15 ? state.balances.sublist(0, 15) : state.balances,
                mobileBuilder: (BuildContext context, Coin? item, bool loading) {
                  if (item == null || loading) {
                    return const SizedShimmer(width: double.infinity, height: 200);
                  }
                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  children: <Widget>[
                                    TokenIcon(size: 24, iconUrl: item.icon),
                                    const SizedBox(width: 12),
                                    Expanded(child: Text(item.name, maxLines: 1, style: const TextStyle(fontSize: 14, color: Color(0xfffbfbfb)))),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                _TokenTypeChip(item.type),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                CoinText(
                                  coin: item,
                                  style: const TextStyle(fontSize: 14, color: Color(0xfffbfbfb)),
                                  textAlign: TextAlign.right,
                                ),
                                if (widget.isMyWallet) ...<Widget>[
                                  const SizedBox(height: 4),
                                  IconTextButton(
                                    text: 'Send',
                                    gap: 4,
                                    reversed: true,
                                    icon: AppIcons.arrow_up_right,
                                    highlightColor: const Color(0xfffbfbfb),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Color(0xff4888f0),
                                    ),
                                    onTap: () => DialogRouter().navigate(SendTokensDialog(initialCoin: item)),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  );
                },
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
                  if (widget.isMyWallet)
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
                              onTap: () => DialogRouter().navigate(SendTokensDialog(initialCoin: item)),
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
      },
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
