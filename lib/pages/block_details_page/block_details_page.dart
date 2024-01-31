import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/pages/block_details_page/block_details_cubit.dart';
import 'package:kira_dashboard/pages/block_details_page/block_details_state.dart';
import 'package:kira_dashboard/widgets/custom_card.dart';
import 'package:kira_dashboard/widgets/page_scaffold.dart';
import 'package:kira_dashboard/widgets/sized_shimmer.dart';

@RoutePage()
class BlockDetailsPage extends StatefulWidget {
  final String height;

  const BlockDetailsPage({
    super.key,
    @PathParam() required this.height,
  });

  @override
  State<StatefulWidget> createState() => _BlockDetailsPageState();
}

class _BlockDetailsPageState extends State<BlockDetailsPage> {
  late final BlockDetailsCubit blockDetailsCubit = BlockDetailsCubit(blockHeight: widget.height);

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

    return BlocBuilder<BlockDetailsCubit, BlockDetailsState>(
      bloc: blockDetailsCubit,
      builder: (BuildContext context, BlockDetailsState state) {
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
                          'Block Details',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: Color(0xfffbfbfb),
                          ),
                        ),
                        Text(
                          '#${widget.height}',
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
                      title: Text('Height', style: titleStyle),
                      value: state.isLoading ? const SizedShimmer(width: 100, height: 16) : Text(state.blockDetails!.height, style: valueStyle),
                    ),
                    const SizedBox(height: 12),
                    _DetailRow(
                      title: Text('Timestamp', style: titleStyle),
                      value: state.isLoading ? const SizedShimmer(width: 100, height: 16) : Text(state.blockDetails!.time.toString(), style: valueStyle),
                    ),
                    const SizedBox(height: 12),
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
