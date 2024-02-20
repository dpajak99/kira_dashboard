import 'package:kira_dashboard/infra/services/blocks_service.dart';
import 'package:kira_dashboard/models/block.dart';
import 'package:kira_dashboard/models/paginated_list_wrapper.dart';
import 'package:kira_dashboard/utils/blocks_paginated_request.dart';
import 'package:kira_dashboard/utils/cubits/list_cubit/list_cubit.dart';
import 'package:kira_dashboard/utils/paginated_request.dart';

class BlocksListCubit extends PaginatedListCubit<Block> {
  final BlocksService blocksService = BlocksService();

  BlocksListCubit() : super(const PaginatedListState.loading());

  @override
  Future<PaginatedListWrapper<Block>> getPage(PaginatedRequest paginatedRequest) {
    int total = networkListCubit.state.currentNetwork!.details!.block;
    if( state.total != -1) {
      total = state.total;
    }

    BlocksPaginatedRequest blocksPaginatedRequest = BlocksPaginatedRequest(
      minHeight: total - paginatedRequest.offset - paginatedRequest.limit,
      maxHeight: total - paginatedRequest.offset,
    );
    return blocksService.getPage(blocksPaginatedRequest);
  }
}
