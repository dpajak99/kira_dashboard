import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/infra/services/balances_service.dart';
import 'package:kira_dashboard/models/coin.dart';
import 'package:kira_dashboard/pages/portfolio_page/balances_page/balances_list_state.dart';
import 'package:kira_dashboard/utils/paginated_request.dart';

class BalancesListCubit extends Cubit<BalancesListState> {
  final BalancesService balancesService = BalancesService();

  final String address;
  final bool isMyWallet;

  BalancesListCubit({
    required this.address,
    required this.isMyWallet,
  }) : super(const BalancesListState(isLoading: true)) {
    _init();
  }

  Future<void> _init() async {
    PaginatedRequest paginatedRequest = const PaginatedRequest(limit: 20, offset: 0);
    List<Coin> balances = await balancesService.getPage(address, paginatedRequest);

    emit(state.copyWith(isLoading: false, balances: balances));
  }
}