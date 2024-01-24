import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/infra/services/verification_requests_service.dart';
import 'package:kira_dashboard/models/verification_request.dart';
import 'package:kira_dashboard/pages/portfolio_page/verification_requests_page/inbound_verification_requests_list_state.dart';
import 'package:kira_dashboard/utils/paginated_request.dart';

class InboundVerificationRequestsListCubit extends Cubit<InboundVerificationRequestsListState> {
  final VerificationRequestsService verificationRequestsService = VerificationRequestsService();

  final String address;
  final bool isMyWallet;

  InboundVerificationRequestsListCubit({
    required this.address,
    required this.isMyWallet,
  }) : super(const InboundVerificationRequestsListState(isLoading: true)) {
    _init();
  }

  Future<void> _init() async {
    PaginatedRequest paginatedRequest = const PaginatedRequest(limit: 20, offset: 0);
    List<VerificationRequest> requests = await verificationRequestsService.getInboundPage(address, paginatedRequest);

    emit(state.copyWith(isLoading: false, requests: requests));
  }
}