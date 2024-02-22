import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/config/theme/app_colors.dart';
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
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle titleStyle = textTheme.bodyMedium!.copyWith(color: CustomColors.secondary);
    TextStyle valueStyle =  textTheme.bodyMedium!.copyWith(color: CustomColors.white);

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
                        Text(
                          'Block Details',
                          style: textTheme.headlineLarge!.copyWith(color: CustomColors.white),
                        ),
                        Text(
                          '#${widget.height}',
                          style: textTheme.titleLarge!.copyWith(color: CustomColors.secondary),
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
