import 'package:equatable/equatable.dart';
import 'package:kira_dashboard/infra/entities/network/network_properties_entity.dart';

class QueryNetworkPropertiesResponse extends Equatable {
  final NetworkPropertiesEntity networkProperties;

  QueryNetworkPropertiesResponse.fromJson(Map<String, dynamic> json)
      : networkProperties = NetworkPropertiesEntity.fromJson(json['properties'] as Map<String, dynamic>);

  @override
  List<Object?> get props => [networkProperties];
}