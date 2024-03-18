import 'package:equatable/equatable.dart';
import 'package:kira_dashboard/models/paginated_list_wrapper.dart';
import 'package:kira_dashboard/utils/cubits/list_cubit/refreshable_page_cubit.dart';
import 'package:kira_dashboard/utils/paginated_request.dart';

class PaginatedListState<T> extends Equatable {
  final int pageSize = 20;
  final bool isLoading;
  final int pageIndex;
  final int total;
  final List<T> items;

  const PaginatedListState({
    required this.items,
    required this.isLoading,
    required this.pageIndex,
    required this.total,
  });

  const PaginatedListState.loading()
      : items = const [],
        isLoading = true,
        pageIndex = -1,
        total = -1;

  const PaginatedListState.loaded({
    required this.items,
    required this.pageIndex,
    required this.total,
  }) : isLoading = false;

  PaginatedListState<T> copyWith({
    List<T>? items,
    int? pageIndex,
    int? total,
    bool? isLoading,
  }) {
    return PaginatedListState<T>(
      items: items ?? this.items,
      pageIndex: pageIndex ?? this.pageIndex,
      total: total ?? this.total,
      isLoading: isLoading ?? this.isLoading,
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

abstract class PaginatedListCubit<T> extends RefreshablePageCubit<PaginatedListState<T>> {
  PaginatedListCubit(super.initialState);

  @override
  Future<void> reload() async {
    emit(const PaginatedListState.loading());
    PaginatedRequest paginatedRequest = PaginatedRequest(offset: 0, limit: state.pageSize);
    PaginatedListWrapper<T> paginationResponse = await getPage(paginatedRequest);

    emit(PaginatedListState.loaded(
      items: paginationResponse.items,
      total: state.total != -1 ? state.total : paginationResponse.total,
      pageIndex: 0,
    ));
  }

  void nextPage() => goToPage(state.pageIndex + 1);

  void previousPage() => goToPage(state.pageIndex - 1);

  void goToPage(int pageIndex) async {
    if (pageIndex < 0) return;
    if(state.isLoading) return;

    emit(state.copyWith(isLoading: true, pageIndex: pageIndex));

    PaginatedRequest paginatedRequest = PaginatedRequest(offset: pageIndex * state.pageSize, limit: state.pageSize);
    PaginatedListWrapper<T> paginationResponse = await getPage(paginatedRequest);

    emit(PaginatedListState.loaded(
      items: paginationResponse.items,
      total: state.total != -1 ? state.total : paginationResponse.total,
      pageIndex: pageIndex,
    ));
  }

  Future<PaginatedListWrapper<T>> getPage(PaginatedRequest paginatedRequest);
}
