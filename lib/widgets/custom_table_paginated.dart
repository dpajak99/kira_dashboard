import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/utils/cubits/list_cubit/list_cubit.dart';
import 'package:kira_dashboard/widgets/custom_table.dart';

class CustomTablePaginated<T> extends StatelessWidget {
  final PaginatedListCubit<T> cubit;
  final ValueChanged<T>? onItemTap;
  final List<ColumnConfig<T>> columns;
  final ElementBuilder<T>? mobileBuilder;

  const CustomTablePaginated({
    required this.cubit,
    this.onItemTap,
    required this.columns,
    required this.mobileBuilder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    ButtonStyle buttonStyle = IconButton.styleFrom(
      foregroundColor: const Color(0xff6c86ad),
      disabledForegroundColor: const Color(0x776c86ad),
    );

    return BlocBuilder<PaginatedListCubit<T>, PaginatedListState<T>>(
      bloc: cubit,
      builder: (BuildContext context, PaginatedListState<T> state) {
        int pageSelectorStart = 0;
        int pageSelectorEnd = min(5, state.totalPages);

        if (state.totalPages > 5) {
          if (state.pageIndex > 2 && state.pageIndex < state.totalPages - 2) {
            pageSelectorStart = state.pageIndex - 2;
            pageSelectorEnd = min(state.pageIndex + 3, state.totalPages);
          } else if (state.pageIndex >= state.totalPages - 2) {
            pageSelectorStart = state.totalPages - 5;
            pageSelectorEnd = state.totalPages;
          }
        }

        Widget pagesWidget = Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = pageSelectorStart; i < pageSelectorEnd; i++) ...<Widget>[
              IconButton(
                onPressed: () => cubit.goToPage(i),
                icon: Text(
                  (i + 1).toString(),
                  style: textTheme.bodyMedium!.copyWith(
                    color: i == state.pageIndex ? const Color(0xff4888f0) : const Color(0xff6c86ad),
                  ),
                ),
              ),
            ],
          ],
        );

        return Column(
          children: [
            CustomTable(
              onItemTap: onItemTap,
              pageSize: state.pageSize,
              loading: state.isLoading,
              items: state.items,
              columns: columns,
              mobileBuilder: mobileBuilder,
            ),
            if (state.pageIndex != -1 && state.total != -1 && state.totalPages > 1) ...[
              const SizedBox(height: 20),
              IgnorePointer(
                ignoring: state.isLoading,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: state.isFirstPage ? null : () => cubit.previousPage(),
                      style: buttonStyle,
                      icon: const Icon(Icons.keyboard_arrow_left),
                    ),
                    IconButton(
                      onPressed: state.isFirstPage ? null : () => cubit.goToPage(0),
                      style: buttonStyle,
                      icon: const Icon(Icons.keyboard_double_arrow_left),
                    ),
                    if (MediaQuery.of(context).size.width > 600) Expanded(child: pagesWidget)
                    else const Spacer(),
                    IconButton(
                      onPressed: state.isLastPage ? null : () => cubit.goToPage(state.totalPages - 1),
                      style: buttonStyle,
                      icon: const Icon(Icons.keyboard_double_arrow_right),
                    ),
                    IconButton(
                      onPressed: state.isLastPage ? null : () => cubit.nextPage(),
                      style: buttonStyle,
                      icon: const Icon(Icons.keyboard_arrow_right),
                    ),
                  ],
                ),
              ),
              if (MediaQuery.of(context).size.width <= 600) pagesWidget,
            ],
          ],
        );
      },
    );
  }
}
