import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kira_dashboard/models/block_transaction.dart';
import 'package:kira_dashboard/pages/block_transactions_page/block_transactions_page_cubit.dart';
import 'package:kira_dashboard/pages/block_transactions_page/block_transactions_page_state.dart';
import 'package:kira_dashboard/utils/router/router.gr.dart';
import 'package:kira_dashboard/widgets/address_text.dart';
import 'package:kira_dashboard/widgets/coin_text.dart';
import 'package:kira_dashboard/widgets/custom_card.dart';
import 'package:kira_dashboard/widgets/custom_table.dart';
import 'package:kira_dashboard/widgets/openable_text.dart';
import 'package:kira_dashboard/widgets/page_scaffold.dart';
import 'package:kira_dashboard/widgets/sized_shimmer.dart';
import 'package:kira_dashboard/widgets/token_icon.dart';

@RoutePage()
class BlockTransactionsPage extends StatefulWidget {
  final String? blockId;

  const BlockTransactionsPage({
    @QueryParam('block') this.blockId,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _BlockTransactionsPageState();
}

class _BlockTransactionsPageState extends State<BlockTransactionsPage> {
  late final BlockTransactionsPageCubit blockTransactionsPageCubit = BlockTransactionsPageCubit(blockId: widget.blockId);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return BlocBuilder<BlockTransactionsPageCubit, BlockTransactionsPageState>(
      bloc: blockTransactionsPageCubit,
      builder: (BuildContext context, BlockTransactionsPageState state) {
        return PageScaffold(
          slivers: [
            SliverToBoxAdapter(
              child: CustomCard(
                title: 'Transactions',
                enableMobile: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTable<BlockTransaction>(
                      items: state.transactions,
                      pageSize: state.pageSize,
                      loading: state.isLoading,
                      mobileBuilder: (BuildContext context, BlockTransaction? item, bool loading) {
                        if (item == null || loading) {
                          return const SizedShimmer(width: double.infinity, height: 200);
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      _MethodChip(item.method),
                                      const SizedBox(height: 4),
                                      Text(
                                        DateFormat('d MMM y, HH:mm').format(item.time),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: textTheme.labelMedium!.copyWith(color: const Color(0xff6c86ad)),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      if (item.amounts.isNotEmpty) ...<Widget>[
                                        Expanded(
                                          child: CoinText(
                                            coin: item.amounts.first,
                                            textAlign: TextAlign.right,
                                            style: textTheme.bodyMedium!.copyWith(color: const Color(0xfffbfbfb)),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        TokenIcon(size: 24, iconUrl: item.amounts.firstOrNull?.icon),
                                      ],
                                      if (item.amounts.length > 1)
                                        Text(
                                          ' + ${item.amounts.length - 1}',
                                          style: textTheme.bodyMedium!.copyWith(color: const Color(0xfffbfbfb)),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Hash',
                              style: textTheme.labelMedium!.copyWith(color: const Color(0xff6c86ad)),
                            ),
                            OpenableHash(
                              hash: item.hash,
                              style: textTheme.bodyMedium!.copyWith(color: const Color(0xff2f8af5)),
                              onTap: () => AutoRouter.of(context).push(ProposalDetailsRoute(proposalId: item.hash)),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'From',
                                        style: textTheme.labelMedium!.copyWith(color: const Color(0xff6c86ad)),
                                      ),
                                      OpenableAddressText(
                                        address: item.from,
                                        style: textTheme.bodyMedium!.copyWith(color: const Color(0xff2f8af5)),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  flex: 4,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'To',
                                        style: textTheme.labelMedium!.copyWith(color: const Color(0xff6c86ad)),
                                      ),
                                      OpenableAddressText(
                                        address: item.to,
                                        style: textTheme.bodyMedium!.copyWith(color: const Color(0xff2f8af5)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                      columns: <ColumnConfig<BlockTransaction>>[
                        ColumnConfig(
                          title: 'Hash',
                          width: 100,
                          cellBuilder: (BuildContext context, BlockTransaction item) {
                            return OpenableHash(
                              hash: item.hash,
                              onTap: () => AutoRouter.of(context).push(TransactionDetailsRoute(hash: item.hash)),
                              style: textTheme.bodyMedium!.copyWith(color: const Color(0xff2f8af5)),
                            );
                          },
                        ),
                        ColumnConfig(
                          title: 'Method',
                          cellBuilder: (BuildContext context, BlockTransaction item) {
                            return _MethodChip(item.method);
                          },
                        ),
                        ColumnConfig(
                          title: 'Date',
                          width: 160,
                          cellBuilder: (BuildContext context, BlockTransaction item) {
                            return Text(
                              DateFormat('d MMM y, HH:mm').format(item.time),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.bodyMedium!.copyWith(color: const Color(0xfffbfbfb)),
                            );
                          },
                        ),
                        ColumnConfig(
                          title: 'From',
                          cellBuilder: (BuildContext context, BlockTransaction item) {
                            return OpenableAddressText(
                              address: item.from,
                              style: textTheme.bodyMedium!.copyWith(color: const Color(0xff2f8af5)),
                            );
                          },
                        ),
                        ColumnConfig(
                          title: ' ',
                          width: 50,
                          cellBuilder: (BuildContext context, BlockTransaction item) {
                            return const Icon(
                              Icons.arrow_forward,
                              color: Color(0xff6c86ad),
                            );
                          },
                        ),
                        ColumnConfig(
                          title: 'To',
                          cellBuilder: (BuildContext context, BlockTransaction item) {
                            return OpenableAddressText(
                              address: item.to,
                              style: textTheme.bodyMedium!.copyWith(color: const Color(0xff2f8af5)),
                            );
                          },
                        ),
                        ColumnConfig(
                          title: 'Value',
                          width: 180,
                          textAlign: TextAlign.right,
                          cellBuilder: (BuildContext context, BlockTransaction item) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if (item.amounts.isNotEmpty) ...<Widget>[
                                  Expanded(
                                    child: CoinText(
                                      coin: item.amounts.first,
                                      textAlign: TextAlign.right,
                                      style: textTheme.bodyMedium!.copyWith(color: const Color(0xfffbfbfb)),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                ] else
                                  Padding(
                                    padding: const EdgeInsets.only(right: 32),
                                    child: Text(
                                      '---',
                                      style: textTheme.bodyMedium!.copyWith(color: const Color(0xfffbfbfb)),
                                    ),
                                  ),
                                TokenIcon(size: 24, iconUrl: item.amounts.firstOrNull?.icon),
                                if (item.amounts.length > 1)
                                  Text(
                                    ' + ${item.amounts.length - 1}',
                                    style: textTheme.bodyMedium!.copyWith(color: const Color(0xfffbfbfb)),
                                  ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _MethodChip extends StatelessWidget {
  final String label;

  const _MethodChip(this.label);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

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
          style: textTheme.bodyMedium!.copyWith(color: const Color(0xff6c86ad)),
        ),
      ),
    );
  }
}
