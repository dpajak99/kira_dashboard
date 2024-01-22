import 'package:kira_dashboard/infra/entities/blocks/block_entity.dart';
import 'package:kira_dashboard/infra/repository/blocks_repository.dart';
import 'package:kira_dashboard/models/block.dart';
import 'package:kira_dashboard/models/block_details.dart';
import 'package:kira_dashboard/utils/paginated_request.dart';

class BlocksService {
  final BlocksRepository blocksRepository = BlocksRepository();

  Future<List<Block>> getPage(PaginatedRequest paginatedRequest) async {
    List<BlockEntity> blocks = await blocksRepository.getPage(paginatedRequest);
    List<Block> blockList = blocks.map((BlockEntity block) => Block.fromEntity(block)).toList();

    return blockList;
  }

  Future<BlockDetails> getDetails(String blockHeight) async {
    BlockDetailsEntity blockDetailsEntity = await blocksRepository.getDetails(blockHeight);
    BlockDetails blockDetails = BlockDetails(
      height: blockHeight,
      time: DateTime.parse(blockDetailsEntity.block.header.time),
    );

    return blockDetails;
  }
}
