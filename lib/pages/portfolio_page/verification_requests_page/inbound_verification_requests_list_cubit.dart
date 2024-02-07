import 'package:kira_dashboard/infra/services/verification_requests_service.dart';
import 'package:kira_dashboard/models/verification_request.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/transaction_cubit.dart';
import 'package:kira_dashboard/utils/cubits/list_cubit/list_cubit.dart';
import 'package:kira_dashboard/utils/paginated_request.dart';

class InboundVerificationRequestsListCubit extends PaginatedListCubit<VerificationRequest> with TransactionMixin {
  final VerificationRequestsService verificationRequestsService = VerificationRequestsService();
  final String address;

  InboundVerificationRequestsListCubit({
    required this.address,
  }) : super(const PaginatedListState.loading());

  @override
  Future<List<VerificationRequest>> getPage(PaginatedRequest paginatedRequest) {
    return verificationRequestsService.getInboundPage(address, paginatedRequest);
  }

  Future<void> approveVerificationRequest(int requestId) async {
    txClient.verifyRecords(
      senderAddress: signerAddress,
      verifyRequestId: requestId,
      approved: true,
    );
  }

  Future<void> rejectVerificationRequest(int requestId) async {
    txClient.verifyRecords(
      senderAddress: signerAddress,
      verifyRequestId: requestId,
      approved: false,
    );
  }
}