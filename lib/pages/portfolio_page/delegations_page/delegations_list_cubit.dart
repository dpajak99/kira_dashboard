import 'package:kira_dashboard/infra/services/delegations_service.dart';
import 'package:kira_dashboard/models/delegation.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/transaction_cubit.dart';
import 'package:kira_dashboard/utils/cubits/list_cubit/list_cubit.dart';
import 'package:kira_dashboard/utils/paginated_request.dart';

class DelegationsListCubit extends PaginatedListCubit<Delegation> with TransactionMixin {
  final DelegationsService delegationsService = DelegationsService();

  final String address;
  final bool isMyWallet;

  DelegationsListCubit({
    required this.address,
    required this.isMyWallet,
  }) : super(const PaginatedListState.loading());

  @override
  Future<List<Delegation>> getPage(PaginatedRequest paginatedRequest) {
    return delegationsService.getPage(address, paginatedRequest);
  }

  Future<void> claimRewards() async {
    txClient.claimRewards(
      senderAddress: signerAddress,
    );
  }
}