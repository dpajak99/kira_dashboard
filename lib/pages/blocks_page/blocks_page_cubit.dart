import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/infra/services/blocks_service.dart';
import 'package:kira_dashboard/models/block.dart';
import 'package:kira_dashboard/pages/blocks_page/blocks_page_state.dart';
import 'package:kira_dashboard/utils/paginated_request.dart';

class BlocksPageCubit extends Cubit<BlocksPageState> {
  final BlocksService blocksService = BlocksService();

  BlocksPageCubit() : super(const BlocksPageState(isLoading: true));

  Future<void> init() async {
    PaginatedRequest paginatedRequest = const PaginatedRequest(limit: 20, offset: 0);
    List<Block> blocks = await blocksService.getPage(paginatedRequest);

    emit(BlocksPageState(
      isLoading: false,
      blocks: blocks,
    ));
  }
}
