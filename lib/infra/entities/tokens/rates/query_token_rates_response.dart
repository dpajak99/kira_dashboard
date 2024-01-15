import 'package:kira_dashboard/infra/entities/tokens/rates/token_rate_entity.dart';

class QueryTokenRatesResponse {
  final List<TokenRateEntity> rates;

  QueryTokenRatesResponse({
    required this.rates,
  });

  factory QueryTokenRatesResponse.fromJson(Map<String, dynamic> json) {
    return QueryTokenRatesResponse(
      rates: (json['data'] as List).map((e) => TokenRateEntity.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }
}
