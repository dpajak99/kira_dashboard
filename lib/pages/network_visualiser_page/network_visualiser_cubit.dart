import 'package:kira_dashboard/infra/services/peers_service.dart';
import 'package:kira_dashboard/pages/network_visualiser_page/network_visualiser_state.dart';
import 'package:kira_dashboard/utils/cubits/list_cubit/refreshable_page_cubit.dart';

class NetworkVisualiserCubit extends RefreshablePageCubit<NetworkVisualiserState> {
  final PeersService peersService = PeersService();

  NetworkVisualiserCubit() : super(const NetworkVisualiserState([]));

  @override
  Future<void> reload() async {
    List<Node> nodes = await peersService.getPublicNodes();
    emit(NetworkVisualiserState(nodes));
  }
}