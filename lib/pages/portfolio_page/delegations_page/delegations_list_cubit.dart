import 'package:kira_dashboard/infra/services/delegations_service.dart';
import 'package:kira_dashboard/models/delegation.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/transaction_cubit.dart';
import 'package:kira_dashboard/pages/portfolio_page/delegations_page/delegations_list_state.dart';
import 'package:kira_dashboard/utils/paginated_request.dart';

class DelegationsListCubit extends TransactionCubit<DelegationsListState> {
  final DelegationsService delegationsService = DelegationsService();

  final String address;
  final bool isMyWallet;

  DelegationsListCubit({
    required this.address,
    required this.isMyWallet,
  }) : super(const DelegationsListState(isLoading: true)) {
    _init();
  }

  Future<void> claimRewards() async {
    txClient.claimRewards(
      senderAddress: signerAddress,
    );
  }

  Future<void> _init() async {
    PaginatedRequest paginatedRequest = const PaginatedRequest(limit: 20, offset: 0);
    List<Delegation> delegations = await delegationsService.getPage(address, paginatedRequest);

    emit(state.copyWith(isLoading: false, delegations: delegations));
  }
}