import 'package:kira_dashboard/infra/services/blocks_service.dart';
import 'package:kira_dashboard/models/block.dart';
import 'package:kira_dashboard/utils/cubits/list_cubit/list_cubit.dart';
import 'package:kira_dashboard/utils/paginated_request.dart';

class BlocksListCubit extends PaginatedListCubit<Block> {
  final BlocksService blocksService = BlocksService();
  BlocksListCubit() : super(const PaginatedListState.loading());

  @override
  Future<List<Block>> getPage(PaginatedRequest paginatedRequest) {
    return blocksService.getPage(paginatedRequest);
  }
}
