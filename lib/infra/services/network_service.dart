import 'package:kira_dashboard/infra/entities/network/interx_headers.dart';
import 'package:kira_dashboard/infra/repository/network_repository.dart';
import 'package:kira_dashboard/models/network_status.dart';

class NetworkService {
  final NetworkRepository networkRepository = NetworkRepository();

  Future<NetworkStatus> getStatus() async {
    InterxHeaders interxHeaders = await networkRepository.getStatus();
    NetworkStatus networkStatus = NetworkStatus(
      block: interxHeaders.block,
      chainId: interxHeaders.chainId,
      hash: interxHeaders.hash,
      requestHash: interxHeaders.requestHash,
      signature: interxHeaders.signature,
      timestamp: interxHeaders.timestamp,
      blockDateTime: interxHeaders.blockDateTime,
    );

    return networkStatus;
  }
}