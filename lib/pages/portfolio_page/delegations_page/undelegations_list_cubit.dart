import 'package:kira_dashboard/infra/services/undelegations_service.dart';
import 'package:kira_dashboard/models/paginated_list_wrapper.dart';
import 'package:kira_dashboard/models/undelegation.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/transaction_cubit.dart';
import 'package:kira_dashboard/utils/cubits/list_cubit/list_cubit.dart';
import 'package:kira_dashboard/utils/paginated_request.dart';

class UndelegationsListCubit extends PaginatedListCubit<Undelegation> with TransactionMixin {
  final UndelegationsService undelegationsService = UndelegationsService();

  final String address;
  final bool isMyWallet;

  UndelegationsListCubit({
    required this.address,
    required this.isMyWallet,
  }) : super(const PaginatedListState.loading());

  @override
  Future<PaginatedListWrapper<Undelegation>> getPage(PaginatedRequest paginatedRequest) {
    return undelegationsService.getPage(address, paginatedRequest);
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