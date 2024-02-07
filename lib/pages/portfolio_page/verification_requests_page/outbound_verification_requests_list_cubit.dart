import 'package:kira_dashboard/infra/services/verification_requests_service.dart';
import 'package:kira_dashboard/models/paginated_list_wrapper.dart';
import 'package:kira_dashboard/models/verification_request.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/transaction_cubit.dart';
import 'package:kira_dashboard/utils/cubits/list_cubit/list_cubit.dart';
import 'package:kira_dashboard/utils/paginated_request.dart';

class OutboundVerificationRequestsListCubit extends PaginatedListCubit<VerificationRequest> with TransactionMixin {
  final VerificationRequestsService verificationRequestsService = VerificationRequestsService();
  final String address;

  OutboundVerificationRequestsListCubit({
    required this.address,
  }) : super(const PaginatedListState.loading());

  @override
  Future<PaginatedListWrapper<VerificationRequest>> getPage(PaginatedRequest paginatedRequest) {
    return verificationRequestsService.getOutboundPage(address, paginatedRequest);
  }

  Future<void> cancelVerificationRequest(int requestId) async {
    txClient.cancelRecordsVerificationRequest(
      senderAddress: signerAddress,
      verifyRequestId: requestId,
    );
  }
}
