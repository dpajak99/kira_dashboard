import 'package:kira_dashboard/infra/services/blocks_service.dart';
import 'package:kira_dashboard/models/block.dart';
import 'package:kira_dashboard/models/paginated_list_wrapper.dart';
import 'package:kira_dashboard/utils/blocks_paginated_request.dart';
import 'package:kira_dashboard/utils/cubits/list_cubit/list_cubit.dart';
import 'package:kira_dashboard/utils/paginated_request.dart';

class BlocksListCubit extends PaginatedListCubit<Block> {
  final BlocksService blocksService = BlocksService();
  int? blockId;

  BlocksListCubit() : super(const PaginatedListState.loading());

  @override
  Future<PaginatedListWrapper<Block>> getPage(PaginatedRequest paginatedRequest) {
    blockId ??= networkListCubit.state.currentNetwork?.details?.block;

    BlocksPaginatedRequest blocksPaginatedRequest = BlocksPaginatedRequest(
      minHeight: blockId! - paginatedRequest.offset - paginatedRequest.limit,
      maxHeight: blockId! - paginatedRequest.offset,
    );
    return blocksService.getPage(blocksPaginatedRequest);
  }
}
