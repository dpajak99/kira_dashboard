import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:kira_dashboard/models/paginated_list_wrapper.dart';
import 'package:kira_dashboard/utils/cubits/list_cubit/refreshable_page_cubit.dart';
import 'package:kira_dashboard/utils/paginated_request.dart';

class InfinityListState<T> extends Equatable {
  final int pageSize = 10;
  final bool isLoading;
  final int pageIndex;
  final int total;
  final List<T> items;

  const InfinityListState({
    required this.items,
    required this.isLoading,
    required this.pageIndex,
    required this.total,
  });

  const InfinityListState.loading()
      : items = const [],
        isLoading = true,
        pageIndex = -1,
        total = -1;

  const InfinityListState.loaded({
    required this.items,
    required this.pageIndex,
    required this.total,
  }) : isLoading = false;

  InfinityListState<T> copyWith({
    List<T>? items,
    int? pageIndex,
    int? total,
    bool? isLoading,
  }) {
    return InfinityListState<T>(
      items: items ?? this.items,
      pageIndex: pageIndex ?? this.pageIndex,
      total: total ?? this.total,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  InfinityListState<T> add({
    required List<T> items,
    required int pageIndex,
  }) {
    return copyWith(
      items: this.items + items,
      pageIndex: pageIndex,
    );
  }

  int get pageNumber => pageIndex + 1;

  bool get isFirstPage => pageIndex == 0;

  bool get isLastPage => pageIndex * pageSize + items.length >= total;

  int get totalPages => (total / pageSize).ceil();

  bool isLastXPages(int x) => pageIndex >= totalPages - x;

  @override
  List<Object?> get props => [isLoading, items];
}

abstract class InfinityListCubit<T> extends RefreshablePageCubit<InfinityListState<T>> {
  static const double nextPageActivatorOffset = 100;
  final ScrollController scrollController;

  InfinityListCubit(super.initialState, {required this.scrollController}) {
    scrollController.addListener(_handleScroll);
  }

  @override
  Future<void> close() {
    scrollController.removeListener(_handleScroll);
    return super.close();
  }

  @override
  Future<void> reload() async {
    emit(const InfinityListState.loading());
    PaginatedRequest paginatedRequest = PaginatedRequest(offset: 0, limit: state.pageSize);
    PaginatedListWrapper<T> paginationResponse = await getPage(paginatedRequest);

    emit(InfinityListState.loaded(
      items: paginationResponse.items,
      total: paginationResponse.total,
      pageIndex: 0,
    ));
  }

  void fetchNextPage() async {
    if(state.isLoading) return;

    emit(state.copyWith(isLoading: true));

    int nextIndex = state.pageIndex + 1;

    PaginatedRequest paginatedRequest = PaginatedRequest(offset: nextIndex * state.pageSize, limit: state.pageSize);
    PaginatedListWrapper<T> paginationResponse = await getPage(paginatedRequest);

    emit(state.add(
      items: paginationResponse.items,
      pageIndex: nextIndex,
    ));
  }

  void _handleScroll() {
    double currentOffset = scrollController.offset;
    double maxOffset = scrollController.position.maxScrollExtent - nextPageActivatorOffset;
    bool reachedMax = currentOffset >= maxOffset;
    if (reachedMax && state.isLoading == false) {
      fetchNextPage();
    }
  }

  Future<PaginatedListWrapper<T>> getPage(PaginatedRequest paginatedRequest);
}
