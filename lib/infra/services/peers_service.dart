import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:kira_dashboard/infra/entities/country_code_entity.dart';
import 'package:kira_dashboard/infra/entities/peers/node_entity.dart';
import 'package:kira_dashboard/infra/repository/country_codes_repository.dart';
import 'package:kira_dashboard/infra/repository/peers_repository.dart';

class Node extends Equatable {
  final String countryCode;

  const Node({
    required this.countryCode,
  });

  @override
  List<Object?> get props => <Object?>[countryCode];
}

class PeersService {
  final PeersRepository peersRepository = PeersRepository();
  final CountryCodesRepository countryCodesRepository = CountryCodesRepository();

  Future<List<Node>> getPublicNodes() async {
    List<CountryCodeEntity> countryCodeList = await countryCodesRepository.getCountryCodes();
    List<NodeEntity> nodeEntityList = await peersRepository.getPublicNodes();

    return nodeEntityList.map((NodeEntity nodeEntity) {
      return Node(countryCode: nodeEntity.countryCode);
    }).toList();
  }
}
