import 'package:equatable/equatable.dart';
import 'package:kira_dashboard/infra/entities/blocks/block_entity.dart';

class QueryBlocksResponse extends Equatable {
  final List<BlockEntity> blockMetas;

  QueryBlocksResponse.fromJson(Map<String, dynamic> json)
      : blockMetas = (json['block_metas'] as List<dynamic>)
            .map((dynamic e) => BlockEntity.fromJson(e as Map<String, dynamic>))
            .toList();

  @override
  List<Object?> get props => <Object?>[blockMetas];
}