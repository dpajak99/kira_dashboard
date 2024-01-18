import 'package:equatable/equatable.dart';
import 'package:kira_dashboard/infra/entities/tokens/aliases/token_alias_entity.dart';

class QueryTokenAliasesResponse extends Equatable {
  final List<TokenAliasEntity> tokenAliasesData;
  final String defaultDenom;
  final String bech32Prefix;

  const QueryTokenAliasesResponse({
    required this.tokenAliasesData,
    required this.defaultDenom,
    required this.bech32Prefix,
  });

  factory QueryTokenAliasesResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> tokenAliasesData = json['token_aliases_data'] != null ? json['token_aliases_data'] as List<dynamic> : List<dynamic>.empty();

    return QueryTokenAliasesResponse(
      tokenAliasesData: tokenAliasesData.map((dynamic e) => TokenAliasEntity.fromJson(e as Map<String, dynamic>)).toList(),
      defaultDenom: json['default_denom'] as String,
      bech32Prefix: json['bech32_prefix'] as String,
    );
  }

  @override
  List<Object?> get props => <Object?>[tokenAliasesData];
}