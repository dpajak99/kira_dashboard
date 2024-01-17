import 'package:equatable/equatable.dart';
import 'package:kira_dashboard/infra/entities/validators/validator_entity.dart';

class QueryValidatorsResponse extends Equatable {
  final List<ValidatorEntity> validators;

  QueryValidatorsResponse.fromJson(Map<String, dynamic> json)
      : validators = (json["validators"] as List<dynamic>? ?? <dynamic>[]).map((x) => ValidatorEntity.fromJson(x)).toList();

  @override
  List<Object?> get props => [validators];
}
