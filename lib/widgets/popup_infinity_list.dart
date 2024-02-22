import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/config/theme/app_colors.dart';
import 'package:kira_dashboard/utils/cubits/list_cubit/infinity_list_cubit.dart';
import 'package:kira_dashboard/widgets/address_text.dart';
import 'package:kira_dashboard/widgets/custom_table.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class PopupInfinityList<T> extends StatefulWidget {
  final InfinityListCubit<T> cubit;
  final ScrollController scrollController;
  final ElementBuilder<T> elementBuilder;

  const PopupInfinityList({
    required this.cubit,
    required this.scrollController,
    required this.elementBuilder,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => PopupInfinityListState<T>();
}

class PopupInfinityListState<T> extends State<PopupInfinityList<T>> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return SizedBox(
      height: 500,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
            decoration: BoxDecoration(
              color: appColors.surface,
              borderRadius: const BorderRadius.all(Radius.circular(16)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: TextEditingController(),
                    style: textTheme.bodyMedium!.copyWith(color: appColors.onBackground),
                    cursorColor: appColors.onBackground,
                    cursorWidth: 1,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      isDense: true,
                      hintText: 'Search by lowest denomination name',
                      hintStyle: textTheme.bodyMedium!.copyWith(color: appColors.secondaryContainer),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                SimpleTextButton(
                  text: 'Search',
                  onTap: () {},
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<InfinityListCubit<T>, InfinityListState<T>>(
              bloc: widget.cubit,
              builder: (BuildContext context, InfinityListState<T> state) {
                return ListView.builder(
                  controller: widget.scrollController,
                  itemCount: state.isLastPage ? state.items.length : state.items.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (!state.isLastPage && index == state.items.length) {
                      return SizedBox(
                        width: double.infinity,
                        child: Center(
                          child: LoadingAnimationWidget.prograssiveDots(color: Colors.white, size: 30),
                        ),
                      );
                    }
                    return widget.elementBuilder(context, state.items[index], false);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
