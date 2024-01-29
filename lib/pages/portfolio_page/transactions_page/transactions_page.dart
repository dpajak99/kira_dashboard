import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kira_dashboard/models/transaction.dart';
import 'package:kira_dashboard/pages/portfolio_page/transactions_page/transactions_list_cubit.dart';
import 'package:kira_dashboard/pages/portfolio_page/transactions_page/transactions_list_state.dart';
import 'package:kira_dashboard/utils/router/router.gr.dart';
import 'package:kira_dashboard/widgets/address_text.dart';
import 'package:kira_dashboard/widgets/coin_text.dart';
import 'package:kira_dashboard/widgets/custom_card.dart';
import 'package:kira_dashboard/widgets/custom_table.dart';
import 'package:kira_dashboard/widgets/openable_text.dart';
import 'package:kira_dashboard/widgets/token_icon.dart';

class TransactionsPage extends StatefulWidget {
  final String address;
  final bool isMyWallet;

  const TransactionsPage({
    super.key,
    required this.address,
    required this.isMyWallet,
  });

  @override
  State<StatefulWidget> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  late final TransactionsListCubit cubit = TransactionsListCubit(address: widget.address, isMyWallet: widget.isMyWallet);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsListCubit, TransactionsListState>(
      bloc: cubit,
      builder: (BuildContext context, TransactionsListState state) {
        return CustomCard(
          title: 'Transactions',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTable<Transaction>(
                pageSize: state.pageSize,
                loading: state.isLoading,
                items: state.transactions,
                columns: <ColumnConfig<Transaction>>[
                  ColumnConfig(
                    title: 'Hash',
                    cellBuilder: (BuildContext context, Transaction item) {
                      return OpenableHash(
                        hash: item.hash,
                        onTap: () => AutoRouter.of(context).push(TransactionDetailsRoute(hash: item.hash)),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xff2f8af5),
                        ),
                      );
                    },
                  ),
                  ColumnConfig(
                    title: 'Method',
                    width: 120,
                    cellBuilder: (BuildContext context, Transaction item) {
                      return _MethodChip(item.method);
                    },
                  ),
                  ColumnConfig(
                    title: 'Date',
                    width: 160,
                    cellBuilder: (BuildContext context, Transaction item) {
                      return Text(
                        DateFormat('d MMM y, HH:mm').format(item.time),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 14, color: Color(0xfffbfbfb)),
                      );
                    },
                  ),
                  ColumnConfig(
                    title: 'From',
                    width: 170,
                    cellBuilder: (BuildContext context, Transaction item) {
                      return OpenableAddressText(
                        address: item.from,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xff2f8af5),
                        ),
                      );
                    },
                  ),
                  ColumnConfig(
                    title: ' ',
                    width: 70,
                    cellBuilder: (BuildContext context, Transaction item) {
                      return _DirectionChip(item.direction);
                    },
                  ),
                  ColumnConfig(
                    title: 'To',
                    width: 170,
                    cellBuilder: (BuildContext context, Transaction item) {
                      return OpenableAddressText(
                        address: item.to,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xff2f8af5),
                        ),
                      );
                    },
                  ),
                  ColumnConfig(
                    title: 'Value',
                    textAlign: TextAlign.right,
                    cellBuilder: (BuildContext context, Transaction item) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (item.amounts.isNotEmpty) ...<Widget>[
                            Expanded(
                              child: CoinText(
                                coin: item.amounts.first,
                                textAlign: TextAlign.right,
                                style: const TextStyle(fontSize: 14, color: Color(0xfffbfbfb)),
                              ),
                            ),
                            const SizedBox(width: 8),
                          ] else
                            const Padding(
                              padding: EdgeInsets.only(right: 32),
                              child: Text(
                                '---',
                                style: TextStyle(fontSize: 14, color: Color(0xfffbfbfb)),
                              ),
                            ),
                          TokenIcon(size: 24, iconUrl: item.amounts.firstOrNull?.icon),
                          if (item.amounts.length > 1)
                            Text(
                              ' + ${item.amounts.length - 1}',
                              style: const TextStyle(fontSize: 14, color: Color(0xfffbfbfb)),
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

class _DirectionChip extends StatelessWidget {
  final String direction;

  const _DirectionChip(this.direction);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: switch (direction) {
            'inbound' => const Color(0x2935b15f),
            'outbound' => const Color(0x29ffa500),
            (_) => const Color(0x2935b15f),
          },
        ),
        child: Text(
          direction == 'outbound' ? 'OUT' : 'IN',
          style: TextStyle(
            fontSize: 12,
            color: switch (direction) {
              'inbound' => const Color(0xff35b15f),
              'outbound' => const Color(0xffffa500),
              (_) => const Color(0x2935b15f),
            },
          ),
        ),
      ),
    );
  }
}

class _MethodChip extends StatelessWidget {
  final String label;

  const _MethodChip(this.label);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xff263042),
        ),
        child: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xff6c86ad),
          ),
        ),
      ),
    );
  }
}
