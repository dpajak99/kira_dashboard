import 'package:equatable/equatable.dart';
import 'package:kira_dashboard/config/predefined_networks.dart';

class SplashPageState extends Equatable {
  const SplashPageState();

  @override
  List<Object> get props => [];
}

class ConnectingState extends SplashPageState {
  final NetworkTemplate network;

  const ConnectingState({
    required this.network,
  });

  @override
  List<Object> get props => [network];
}

class DisconnectedState extends SplashPageState {
  final NetworkTemplate network;

  const DisconnectedState({
    required this.network,
  });

  @override
  List<Object> get props => [network];
}
