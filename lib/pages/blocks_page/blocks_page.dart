import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:kira_dashboard/widgets/sliver_page_padding.dart';

@RoutePage()
class BlocksPage extends StatefulWidget {
  const BlocksPage({super.key});

  @override
  State<StatefulWidget> createState() => _BlocksPageState();
}

class _BlocksPageState extends State<BlocksPage> {
  final BlocksPageCubit blocksPageCubit = BlocksPageCubit();

  @override
  void initState() {
    super.initState();
    blocksPageCubit.init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocksPageCubit, BlocksPageState>(
      bloc: blocksPageCubit,
      builder: (BuildContext context, BlocksPageState state) {
        return PageScaffold(
          slivers: [
            SliverPagePadding(
              sliver: SliverToBoxAdapter(
                child: CustomCard(
                  title: 'Blocks',
                  child: CustomTable<Block>(
                    items: state.blocks,
                    columns: [
                      ColumnConfig(
                        title: 'Height',
                        width: 120,
                        cellBuilder: (BuildContext context, Block item) {
                          return OpenableText(
                            text: item.height,
                            onTap: () => AutoRouter.of(context).push(BlockDetailsRoute(height: item.height)),
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
            ),
          ],
        );
      },
    );
  }
}
