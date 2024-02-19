import 'package:kira_dashboard/config/predefined_networks.dart';
import 'package:kira_dashboard/infra/entities/network/interx_headers.dart';
import 'package:kira_dashboard/infra/entities/tokens/aliases/token_info_dto.dart';
import 'package:kira_dashboard/infra/repository/network_repository.dart';
import 'package:kira_dashboard/infra/repository/token_aliases_repository.dart';
import 'package:kira_dashboard/pages/dialogs/network_dialog/network_status.dart';
import 'package:kira_dashboard/utils/network_utils.dart';

class NetworkService {
  final NetworkRepository networkRepository = NetworkRepository();
  final TokenAliasesRepository tokenAliasesRepository = TokenAliasesRepository();

  Future<NetworkStatus> getStatusForNetwork(NetworkTemplate networkTemplate) async {
    try {
      InterxHeaders interxHeaders = await networkRepository.getStatusForUri(networkTemplate.interxUrl);
      TokenInfoDto tokenInfoDto = await tokenAliasesRepository.getDefaultTokenInfoForUri(networkTemplate.interxUrl);

      NetworkDetails networkDetails = NetworkDetails(
        defaultDenom: tokenInfoDto.defaultDenom,
        defaultAddressPrefix: tokenInfoDto.addressPrefix,
        block: interxHeaders.block,
        chainId: interxHeaders.chainId,
        hash: interxHeaders.hash,
        requestHash: interxHeaders.requestHash,
        signature: interxHeaders.signature,
        blockDateTime: interxHeaders.blockDateTime,
      );

      List<NetworkWarnings> warnings = [];
      if(networkDetails.blockDateTime.difference(DateTime.now()) > const Duration(minutes: 5)) {
        warnings.add(NetworkWarnings.blockTimeOutOfDate);
      }

      return NetworkStatus(
        custom: networkTemplate.custom,
        name: networkTemplate.name ?? networkDetails.chainId,
        interxUrl: networkTemplate.interxUrl,
        warnings: warnings,
        proxyEnabled: NetworkUtils.shouldUseProxy(Uri.base, networkTemplate.interxUrl),
        status: warnings.isEmpty ? NetworkStatusType.online : NetworkStatusType.unhealthy,
        details: networkDetails,
      );
    } catch (e) {
      return NetworkStatus(
        custom: networkTemplate.custom,
        name: networkTemplate.name ?? 'unknown',
        interxUrl: networkTemplate.interxUrl,
        status: NetworkStatusType.offline,
      );
    }
  }
}
