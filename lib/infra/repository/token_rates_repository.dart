import 'package:dio/dio.dart';
import 'package:kira_dashboard/infra/entities/tokens/rates/query_token_rates_response.dart';
import 'package:kira_dashboard/infra/entities/tokens/rates/token_rate_entity.dart';
import 'package:kira_dashboard/infra/repository/api_repository.dart';
import 'package:kira_dashboard/utils/logger/app_logger.dart';

class TokenRatesRepository extends ApiRepository {
  Future<Map<String, TokenRateEntity>> getAllAsMap() async {
    try {
    Map<String, TokenRateEntity> tokenRatesMap = <String, TokenRateEntity>{};

    List<TokenRateEntity> tokenRates = await getAll();
    for(TokenRateEntity tokenRate in tokenRates) {
      tokenRatesMap[tokenRate.denom] = tokenRate;
    }
    return tokenRatesMap;
    } catch (e) {
      AppLogger().log(message: 'TokenRatesRepository');
      rethrow;
    }
  }

  Future<List<TokenRateEntity>> getAll() async {
    try {
    Response<Map<String, dynamic>> response = await httpClient.get('/api/kira/tokens/rates');
    QueryTokenRatesResponse queryTokenRatesResponse = QueryTokenRatesResponse.fromJson(response.data!);
    return queryTokenRatesResponse.rates;
    } catch (e) {
      AppLogger().log(message: 'TokenRatesRepository');
      rethrow;
    }
  }
}