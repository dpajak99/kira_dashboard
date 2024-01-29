import 'package:kira_dashboard/infra/services/undelegations_service.dart';
import 'package:kira_dashboard/models/undelegation.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/transaction_cubit.dart';
import 'package:kira_dashboard/pages/portfolio_page/delegations_page/undelegations_list_state.dart';
import 'package:kira_dashboard/utils/cubits/list_cubit/list_cubit.dart';
import 'package:kira_dashboard/utils/paginated_request.dart';

class UndelegationsListCubit extends ListCubit<UndelegationsListState> with TransactionMixin {
  final UndelegationsService undelegationsService = UndelegationsService();

  final String address;
  final bool isMyWallet;

  UndelegationsListCubit({
    required this.address,
    required this.isMyWallet,
  }) : super(const UndelegationsListState(isLoading: true));

  @override
  Future<void> reload() async {
    emit(const UndelegationsListState(isLoading: true));

    PaginatedRequest paginatedRequest = const PaginatedRequest(limit: 20, offset: 0);
    List<Undelegation> undelegations = await undelegationsService.getPage(address, paginatedRequest);

    emit(state.copyWith(isLoading: false, undelegations: undelegations));
  }

  Future<void> claimUndelegation({
    required String undelegationId,
    String? memo,
  }) async {
    txClient.claimUndelegation(
      senderAddress: signerAddress,
      undelegationId: undelegationId,
    );
  }
}