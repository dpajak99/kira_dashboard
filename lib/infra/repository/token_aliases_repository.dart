import 'package:dio/dio.dart';
import 'package:kira_dashboard/infra/entities/tokens/aliases/query_token_aliases_response.dart';
import 'package:kira_dashboard/infra/entities/tokens/aliases/token_alias_entity.dart';
import 'package:kira_dashboard/infra/repository/api_repository.dart';
import 'package:kira_dashboard/utils/logger/app_logger.dart';

class TokenAliasesRepository extends ApiRepository {
  Future<String> getDefaultCoinDenom() async {
    Response<Map<String, dynamic>> response = await httpClient.get('/api/kira/tokens/aliases');
    QueryTokenAliasesResponse queryTokenAliasesResponse = QueryTokenAliasesResponse.fromJson(response.data!);
    return queryTokenAliasesResponse.defaultDenom;
  }

  Future<Map<String, TokenAliasEntity>> getAllAsMap() async {
    try {
      Map<String, TokenAliasEntity> tokenAliasesMap = <String, TokenAliasEntity>{};

      List<TokenAliasEntity> tokenAliases = await getAll();
      for (TokenAliasEntity tokenAlias in tokenAliases) {
        tokenAliasesMap[tokenAlias.denoms.first] = tokenAlias;
      }
      return tokenAliasesMap;
    } catch (e) {
      AppLogger().log(message: 'TokenAliasesRepository');
      rethrow;
    }
  }

  Future<List<TokenAliasEntity>> getAll() async {
    try {
      Response<Map<String, dynamic>> response = await httpClient.get('/api/kira/tokens/aliases');
      QueryTokenAliasesResponse queryTokenAliasesResponse = QueryTokenAliasesResponse.fromJson(response.data!);

      return queryTokenAliasesResponse.tokenAliasesData;
    } catch (e) {
      AppLogger().log(message: 'TokenAliasesRepository');
      rethrow;
    }
  }
}