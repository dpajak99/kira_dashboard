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
    return BlocBuilder<PaginatedListCubit<T>, PaginatedListState<T>>(
      bloc: cubit,
      builder: (BuildContext context, PaginatedListState<T> state) {
        return CustomTable(
          onItemTap: onItemTap,
          pageSize: state.pageSize,
          loading: state.isLoading,
          items: state.items,
          columns: columns,
          mobileBuilder: mobileBuilder,
        );
      },
    );
  }
}
