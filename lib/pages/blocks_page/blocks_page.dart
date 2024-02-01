import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kira_dashboard/models/block.dart';
import 'package:kira_dashboard/pages/blocks_page/blocks_page_cubit.dart';
import 'package:kira_dashboard/pages/blocks_page/blocks_page_state.dart';
import 'package:kira_dashboard/utils/router/router.gr.dart';
import 'package:kira_dashboard/widgets/address_text.dart';
import 'package:kira_dashboard/widgets/avatar/identity_avatar.dart';
import 'package:kira_dashboard/widgets/custom_card.dart';
import 'package:kira_dashboard/widgets/custom_table.dart';
import 'package:kira_dashboard/widgets/openable_text.dart';
import 'package:kira_dashboard/widgets/page_scaffold.dart';
import 'package:kira_dashboard/widgets/sized_shimmer.dart';
import 'package:shimmer/shimmer.dart';

@RoutePage()
class BlocksPage extends StatefulWidget {
  const BlocksPage({super.key});

  @override
  State<StatefulWidget> createState() => _BlocksPageState();
}

class _BlocksPageState extends State<BlocksPage> {
  final BlocksPageCubit blocksPageCubit = BlocksPageCubit();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocksPageCubit, BlocksPageState>(
      bloc: blocksPageCubit,
      builder: (BuildContext context, BlocksPageState state) {
        return PageScaffold(
          slivers: [
            SliverToBoxAdapter(
              child: CustomCard(
                childPadding: EdgeInsets.zero,
                enableMobile: true,
                title: 'Blocks',
                child: CustomTable<Block>(
                  onItemTap: (Block item) => AutoRouter.of(context).push(BlockDetailsRoute(height: item.height)),
                  pageSize: state.pageSize,
                  loading: state.isLoading,
                  items: state.blocks,
                  mobileBuilder: (BuildContext context, Block? item, bool loading) {
                    if (item == null || loading) {
                      return const SizedShimmer(width: double.infinity, height: 200);
                    }
                    String hrTime = item.time.difference(DateTime.now()).inSeconds > 0
                        ? '${item.time.difference(DateTime.now()).inSeconds.abs()} sec ago'
                        : '${item.time.difference(DateTime.now()).inMinutes.abs()} min ago';

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        OpenableText(
                          text: 'Block #${item.height}',
                          style: const TextStyle(fontSize: 16, color: Color(0xfffbfbfb)),
                          onTap: () => AutoRouter.of(context).push(BlockDetailsRoute(height: item.height)),
                        ),
                        const SizedBox(height: 4),
                        CopyableHash(
                          hash: '0x${item.hash}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xff6c86ad),
                          ),
                        ),
                        const SizedBox(height: 8),
                        _MobileRow(
                          title: const Text(
                            'Block time:',
                            style: TextStyle(fontSize: 12, color: Color(0xff6c86ad)),
                          ),
                          value: RichText(
                            text: TextSpan(
                              text: '${DateFormat('d MMM y, HH:mm').format(item.time)} ($hrTime)',
                              style: const TextStyle(fontSize: 12, color: Color(0xfffbfbfb)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        _MobileRow(
                          title: const Text(
                            'Proposed by:',
                            style: TextStyle(fontSize: 12, color: Color(0xff6c86ad)),
                          ),
                          value: Row(
                            children: [
                              IdentityAvatar(size: 16, address: item.proposer),
                              const SizedBox(width: 4),
                              OpenableAddressText(
                                address: item.proposer,
                                style: const TextStyle(fontSize: 12, color: Color(0xfffbfbfb)),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        _MobileRow(
                          title: const Text(
                            'Transactions:',
                            style: TextStyle(fontSize: 12, color: Color(0xff6c86ad)),
                          ),
                          value: OpenableText(
                            text: item.numTxs,
                            onTap: () => AutoRouter.of(context).push(BlockTransactionsRoute(blockId: item.height)),
                            style: const TextStyle(fontSize: 12, color: Color(0xfffbfbfb)),
                          ),
                        ),
                      ],
                    );
                  },
                  columns: [
                    ColumnConfig(
                      title: 'Height',
                      width: 120,
                      cellBuilder: (BuildContext context, Block item) {
                        return Text(
                          item.height,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xfffbfbfb),
                          ),
                        );
                      },
                    ),
                    ColumnConfig(
                      title: 'Proposer',
                      width: 240,
                      cellBuilder: (BuildContext context, Block item) {
                        return Row(
                          children: <Widget>[
                            IdentityAvatar(size: 32, address: item.proposer),
                            const SizedBox(width: 12),
                            Expanded(child: OpenableAddressText(address: item.proposer, style: const TextStyle(fontSize: 14, color: Color(0xfffbfbfb)))),
                          ],
                        );
                      },
                    ),
                    ColumnConfig(
                      title: 'Hash',
                      cellBuilder: (BuildContext context, Block item) {
                        return Text(
                          item.hash,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xfffbfbfb),
                          ),
                        );
                      },
                    ),
                    ColumnConfig(
                      title: 'Transactions',
                      cellBuilder: (BuildContext context, Block item) {
                        return OpenableText(
                          text: item.numTxs,
                          onTap: () => AutoRouter.of(context).push(BlockTransactionsRoute(blockId: item.height)),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xfffbfbfb),
                          ),
                        );
                      },
                    ),
                    ColumnConfig(
                      title: 'Age',
                      cellBuilder: (BuildContext context, Block item) {
                        return Text(
                          item.time.difference(DateTime.now()).inSeconds > 0
                              ? '${item.time.difference(DateTime.now()).inSeconds.abs()} seconds ago'
                              : '${item.time.difference(DateTime.now()).inMinutes.abs()} minutes ago',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xfffbfbfb),
                          ),
                        );
                      },
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

class _MobileRow extends StatelessWidget {
  final Widget title;
  final Widget value;

  const _MobileRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: title,
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 2,
          child: value,
        ),
      ],
    );
  }
}
