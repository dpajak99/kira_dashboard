import 'package:dio/dio.dart';
import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/config/network_provider.dart';
import 'package:kira_dashboard/infra/entities/tokens/aliases/token_alias_entity.dart';

class TokenAliasesRepository {
  final Dio httpClient = getIt<NetworkProvider>().httpClient;

  Future<Map<String, TokenAliasEntity>> getAllAsMap() async {
    Map<String, TokenAliasEntity> tokenAliasesMap = <String, TokenAliasEntity>{};

    List<TokenAliasEntity> tokenAliases = await getAll();
    for(TokenAliasEntity tokenAlias in tokenAliases) {
      tokenAliasesMap[tokenAlias.denoms.first] = tokenAlias;
    }
    return tokenAliasesMap;
  }

  Future<List<TokenAliasEntity>> getAll() async {
    Response<List<dynamic>> response = await httpClient.get('/api/kira/tokens/aliases');
    List<TokenAliasEntity> tokenAliases = response.data!.map((dynamic e) => TokenAliasEntity.fromJson(e as Map<String, dynamic>)).toList();

    return tokenAliases;
  }
}