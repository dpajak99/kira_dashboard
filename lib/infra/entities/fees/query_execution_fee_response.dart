import 'package:equatable/equatable.dart';
import 'package:kira_dashboard/infra/entities/fees/fee_config_entity.dart';

class QueryExecutionFeeResponse extends Equatable {
  final FeeConfigEntity fee;

  QueryExecutionFeeResponse.fromJson(Map<String, dynamic> json)
      : fee = FeeConfigEntity.fromJson(json['fee'] as Map<String, dynamic>);

  @override
  List<Object?> get props => [fee];
}