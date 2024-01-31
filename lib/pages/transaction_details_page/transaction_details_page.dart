import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_view/json_view.dart';
import 'package:kira_dashboard/models/transaction_result.dart';
import 'package:kira_dashboard/pages/transaction_details_page/transaction_details_cubit.dart';
import 'package:kira_dashboard/pages/transaction_details_page/transaction_details_state.dart';
import 'package:kira_dashboard/utils/router/router.gr.dart';
import 'package:kira_dashboard/widgets/address_text.dart';
import 'package:kira_dashboard/widgets/custom_card.dart';
import 'package:kira_dashboard/widgets/openable_text.dart';
import 'package:kira_dashboard/widgets/page_scaffold.dart';
import 'package:kira_dashboard/widgets/sized_shimmer.dart';

@RoutePage()
class TransactionDetailsPage extends StatefulWidget {
  final String hash;

  const TransactionDetailsPage({
    @PathParam("hash") required this.hash,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _TransactionDetailsPageState();
}

class _TransactionDetailsPageState extends State<TransactionDetailsPage> {
  late final TransactionDetailsCubit cubit = TransactionDetailsCubit(hash: widget.hash);

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = const TextStyle(
      fontSize: 14,
      color: Color(0xff6c86ad),
    );

    TextStyle valueStyle = const TextStyle(
      fontSize: 14,
      color: Color(0xfffbfbfb),
    );

    return BlocBuilder<TransactionDetailsCubit, TransactionDetailsState>(
      bloc: cubit,
      builder: (BuildContext context, TransactionDetailsState state) {
        return PageScaffold(
          slivers: [
            SliverToBoxAdapter(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Transaction Details',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: Color(0xfffbfbfb),
                          ),
                        ),
                        CopyableText(
                          text: widget.hash,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xff6c86ad),
                          ),
                        )
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.share,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
            const SliverPadding(padding: EdgeInsets.only(top: 32)),
            SliverToBoxAdapter(
              child: CustomCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _DetailRow(
                      title: Text('Transaction Hash', style: titleStyle),
                      value: Text(widget.hash, style: valueStyle),
                    ),
                    const SizedBox(height: 12),
                    _DetailRow(
                      title: Text('Status', style: titleStyle),
                      value: state.isLoading ? const SizedShimmer(width: 100, height: 16) : _StatusChip(status: state.transactionResult!.status),
                    ),
                    const SizedBox(height: 12),
                    _DetailRow(
                      title: Text('Block', style: titleStyle),
                      value: state.isLoading
                          ? const SizedShimmer(width: 100, height: 16)
                          : Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                OpenableText(
                                  text: state.transactionResult!.blockHeight.toString(),
                                  style: valueStyle,
                                  onTap: () => AutoRouter.of(context).push(BlockDetailsRoute(height: state.transactionResult!.blockHeight.toString())),
                                ),
                                const SizedBox(width: 16),
                                _MethodChip('${state.transactionResult!.confirmation} Block Confirmations'),
                              ],
                            ),
                    ),
                    const SizedBox(height: 12),
                    _DetailRow(
                      title: Text('Timestamp', style: titleStyle),
                      value: state.isLoading
                          ? const SizedShimmer(width: 100, height: 16)
                          : Text(state.transactionResult!.blockTimestamp.toString(), style: valueStyle),
                    ),
                    const SizedBox(height: 12),
                    const Divider(color: Color(0xff222b3a)),
                    const SizedBox(height: 12),
                    if (state.transactionResult?.msgs.isNotEmpty ?? false)
                      _DetailRow(
                        title: Text('Method', style: titleStyle),
                        value: state.isLoading
                            ? const SizedShimmer(width: 100, height: 16)
                            : _MethodChip(state.transactionResult!.msgs.first.runtimeType.toString()),
                      ),
                    const SizedBox(height: 12),
                    _DetailRow(
                      title: Text('Memo', style: titleStyle),
                      value: state.isLoading ? const SizedShimmer(width: 100, height: 16) : Text(state.transactionResult!.memo, style: valueStyle),
                    ),
                    if (state.transactionResult?.msgs.length == 1) ...<Widget>[
                      const SizedBox(height: 12),
                      _DetailRow(
                        title: Text('From', style: titleStyle),
                        value: OpenableAddressText(
                          address: state.transactionResult!.msgs.first.from,
                          style: valueStyle.copyWith(
                            color: const Color(0xff2f8af5),
                          ),
                          full: true,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _DetailRow(
                        title: Text('To', style: titleStyle),
                        value: OpenableAddressText(
                          address: state.transactionResult!.msgs.first.to,
                          style: valueStyle.copyWith(
                            color: const Color(0xff2f8af5),
                          ),
                          full: true,
                        ),
                      ),
                    ],
                    const SizedBox(height: 12),
                    if (state.transactionResult?.msgs.isNotEmpty ?? false) ...<Widget>[
                      Text(state.transactionResult!.msgs.length > 1 ? 'Transactions:' : 'Transaction:', style: titleStyle),
                      const SizedBox(height: 6),
                      Column(
                        children: [
                          ...?state.transactionResult?.msgs.map(
                            (e) {
                              return Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: const Color(0xff06070a),
                                ),
                                child: JsonView(
                                  json: e.toJson(),
                                  shrinkWrap: true,
                                ),
                              );
                            },
                          )
                        ],
                      ),
                      const SizedBox(height: 12),
                    ],
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

class _DetailRow extends StatelessWidget {
  final Widget title;
  final Widget value;

  const _DetailRow({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: title),
        Expanded(flex: 4, child: value),
      ],
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

class _StatusChip extends StatelessWidget {
  final TxStatusType status;

  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: switch (status) {
            TxStatusType.confirmed => const Color(0x2935b15f),
            TxStatusType.pending => const Color(0x29ffa500),
            TxStatusType.failed => const Color(0x29f12e1f),
          },
        ),
        child: Text(
          switch (status) {
            TxStatusType.confirmed => 'Confirmed',
            TxStatusType.pending => 'Pending',
            TxStatusType.failed => 'Failed',
          },
          style: TextStyle(
            fontSize: 12,
            color: switch (status) {
              TxStatusType.confirmed => const Color(0xff35b15f),
              TxStatusType.pending => const Color(0xffffa500),
              TxStatusType.failed => const Color(0xfff12e1f),
            },
          ),
        ),
      ),
    );
  }
}
