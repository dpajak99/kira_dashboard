import 'package:kira_dashboard/infra/services/balances_service.dart';
import 'package:kira_dashboard/models/coin.dart';
import 'package:kira_dashboard/utils/cubits/list_cubit/list_cubit.dart';
import 'package:kira_dashboard/utils/paginated_request.dart';

class BalancesListCubit extends PaginatedListCubit<Coin> {
  final BalancesService balancesService = BalancesService();

  final String address;
  final bool isMyWallet;

  BalancesListCubit({
    required this.address,
    required this.isMyWallet,
  }) : super(const PaginatedListState.loading());

  @override
  Future<List<Coin>> getPage(PaginatedRequest paginatedRequest) {
    return balancesService.getPage(address, paginatedRequest);
  }
}