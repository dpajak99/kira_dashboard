import 'package:dio/browser.dart';
import 'package:dio/dio.dart';
import 'package:kira_dashboard/infra/entities/tokens/rates/query_token_rates_response.dart';
import 'package:kira_dashboard/infra/entities/tokens/rates/token_rate_entity.dart';

class TokenRatesRepository {
  final Dio httpClient = DioForBrowser(BaseOptions(
    baseUrl: 'http://65.108.86.252:11000/',
  ));

  Future<Map<String, TokenRateEntity>> getAllAsMap() async {
    Map<String, TokenRateEntity> tokenRatesMap = <String, TokenRateEntity>{};

    List<TokenRateEntity> tokenRates = await getAll();
    for(TokenRateEntity tokenRate in tokenRates) {
      tokenRatesMap[tokenRate.denom] = tokenRate;
    }
    return tokenRatesMap;
  }

  Future<List<TokenRateEntity>> getAll() async {
    Response<Map<String, dynamic>> response = await httpClient.get('/api/kira/tokens/rates');
    QueryTokenRatesResponse queryTokenRatesResponse = QueryTokenRatesResponse.fromJson(response.data!);
    return queryTokenRatesResponse.rates;
  }
}