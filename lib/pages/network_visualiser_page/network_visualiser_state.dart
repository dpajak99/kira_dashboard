import 'package:equatable/equatable.dart';
import 'package:kira_dashboard/infra/services/peers_service.dart';

class NetworkVisualiserState extends Equatable {
  final List<Node> nodes;

  const NetworkVisualiserState(this.nodes);

  @override
  List<Object?> get props => <Object?>[];
}