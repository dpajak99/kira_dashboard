import 'package:kira_dashboard/infra/entities/blocks/block_entity.dart';
import 'package:kira_dashboard/infra/entities/paginated_response_wrapper.dart';
import 'package:kira_dashboard/infra/repository/blocks_repository.dart';
import 'package:kira_dashboard/models/block.dart';
import 'package:kira_dashboard/models/block_details.dart';
import 'package:kira_dashboard/models/paginated_list_wrapper.dart';
import 'package:kira_dashboard/utils/blocks_paginated_request.dart';
import 'package:kira_dashboard/utils/paginated_request.dart';

class BlocksService {
  final BlocksRepository blocksRepository = BlocksRepository();

  Future<PaginatedListWrapper<Block>> getPage(BlocksPaginatedRequest paginatedRequest) async {
    PaginatedResponseWrapper<BlockEntity> response = await blocksRepository.getPage(paginatedRequest);
    List<Block> blockList = response.items.map((BlockEntity block) => Block.fromEntity(block)).toList();

    return PaginatedListWrapper<Block>(items: blockList, total: response.total);
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
