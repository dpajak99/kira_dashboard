import 'package:equatable/equatable.dart';
import 'package:kira_dashboard/config/predefined_networks.dart';

enum NetworkStatusType {
  online,
  unhealthy,
  offline,
  connecting,
}

enum NetworkWarnings {
  blockTimeOutOfDate,
}

class NetworkStatus extends Equatable {
  final String? name;
  final Uri interxUrl;
  final List<NetworkWarnings> warnings;
  final NetworkStatusType status;
  final NetworkDetails? details;

  const NetworkStatus({
    required this.interxUrl,
    required this.status,
    this.name,
    this.details,
    this.warnings = const [],
  });

  NetworkTemplate get networkTemplate => NetworkTemplate(name: name, interxUrl: interxUrl);

  bool compareUri(Uri? uri) {
    if (uri == null) return false;
    return networkTemplate.interxUrl == uri;
  }

  @override
  List<Object?> get props => [name, interxUrl, status];
}

class NetworkDetails extends Equatable {
  final int block;
  final String defaultDenom;
  final String defaultAddressPrefix;
  final String chainId;
  final String hash;
  final String requestHash;
  final String signature;
  final DateTime blockDateTime;

  const NetworkDetails({
    required this.defaultDenom,
    required this.defaultAddressPrefix,
    required this.chainId,
    required this.block,
    required this.hash,
    required this.requestHash,
    required this.signature,
    required this.blockDateTime,
  });
  
  @override
  List<Object?> get props => [block, chainId, hash, requestHash, signature, blockDateTime];
}
