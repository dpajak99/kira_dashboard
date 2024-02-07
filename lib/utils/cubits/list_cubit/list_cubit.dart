import 'package:equatable/equatable.dart';
import 'package:kira_dashboard/utils/cubits/list_cubit/refreshable_page_cubit.dart';
import 'package:kira_dashboard/utils/paginated_request.dart';

class PaginatedListState<T> extends Equatable {
  final int pageSize = 10;
  final bool isLoading;
  final List<T> items;

  const PaginatedListState.loading() : items = const [], isLoading = true;

  const PaginatedListState.loaded({
    required this.items,
  }) : isLoading = false;

  @override
  List<Object?> get props => [isLoading, items];

}

abstract class PaginatedListCubit<T> extends RefreshablePageCubit<PaginatedListState<T>> {
  PaginatedListCubit(super.initialState);

  @override
  Future<void> reload() async {
    emit(const PaginatedListState.loading());
    PaginatedRequest paginatedRequest = PaginatedRequest(offset: 0, limit: state.pageSize);
    List<T> items = await getPage(paginatedRequest);
    emit(PaginatedListState.loaded(items: items));
  }

  Future<List<T>> getPage(PaginatedRequest paginatedRequest);
}