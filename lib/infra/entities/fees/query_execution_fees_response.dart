import 'package:equatable/equatable.dart';
import 'package:kira_dashboard/infra/entities/fees/fee_config_entity.dart';

class QueryExecutionFeesResponse extends Equatable {
  final List<FeeConfigEntity> fees;

  QueryExecutionFeesResponse.fromJson(Map<String, dynamic> json)
      : fees = (json['fees'] as List).map((i) => FeeConfigEntity.fromJson(i)).toList();

  @override
  List<Object?> get props => [fees];
}