import 'package:equatable/equatable.dart';
import 'package:kira_dashboard/infra/entities/peers/node_entity.dart';

class QueryP2PResponse extends Equatable {
  final int lastUpdate;
  final List<NodeEntity> nodeList;

  const QueryP2PResponse({
    required this.lastUpdate,
    required this.nodeList,
  });

  factory QueryP2PResponse.fromJson(Map<String, dynamic> json) {
    return QueryP2PResponse(
      lastUpdate: json['last_update'] as int,
      nodeList:
      json['node_list'] == null ? <NodeEntity>[] : ((json['node_list'] as List<dynamic>).map((dynamic e) => NodeEntity.fromJson(e as Map<String, dynamic>)).toList()),
    );
  }

  @override
  List<Object?> get props => <Object?>[lastUpdate, nodeList];
}
