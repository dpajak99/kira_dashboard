import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:kira_dashboard/infra/entities/peers/node_entity.dart';
import 'package:kira_dashboard/infra/entities/peers/query_p2p_response.dart';

class PeersRepository  {
  Future<List<NodeEntity>> getPublicNodes() async {
    String response = await rootBundle.loadString('mocked_p2p_response.json');
    Map<String, dynamic> jsonResponse = await json.decode(response) as Map<String, dynamic>;
    QueryP2PResponse queryP2PResponse = QueryP2PResponse.fromJson(jsonResponse);
    return queryP2PResponse.nodeList;
  }
}
