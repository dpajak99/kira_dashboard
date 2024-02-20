import 'package:equatable/equatable.dart';
import 'package:kira_dashboard/pages/dialogs/network_dialog/network_status.dart';

class NetworkState extends Equatable {
  final NetworkStatus? currentNetwork;
  final List<NetworkStatus> availableNetworks;

  const NetworkState({
    required this.currentNetwork,
    required this.availableNetworks,
  });

  NetworkState copyWith({
    NetworkStatus? currentNetwork,
    List<NetworkStatus>? availableNetworks,
  }) {
    return NetworkState(
      currentNetwork: currentNetwork ?? this.currentNetwork,
      availableNetworks: availableNetworks ?? this.availableNetworks,
    );
  }

  bool get isConnected {
    return currentNetwork != null && [NetworkStatusType.online, NetworkStatusType.unhealthy].contains(currentNetwork!.status) ;
  }

  bool get isConnecting {
    return currentNetwork != null && currentNetwork!.status == NetworkStatusType.connecting;
  }

  List<NetworkStatus> get all {
    return [
      if (currentNetwork != null) currentNetwork!,
      ...availableNetworks,
    ];
  }

  String get defaultDenom => currentNetwork?.details?.defaultDenom ?? '';

  @override
  List<Object?> get props => [currentNetwork, availableNetworks];
}
