import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/config/wallet_provider.dart';
import 'package:kira_dashboard/infra/services/balances_service.dart';
import 'package:kira_dashboard/infra/services/delegations_service.dart';
import 'package:kira_dashboard/infra/services/identity_registrar_service.dart';
import 'package:kira_dashboard/infra/services/transactions_service.dart';
import 'package:kira_dashboard/infra/services/undelegations_service.dart';
import 'package:kira_dashboard/infra/services/validators_service.dart';
import 'package:kira_dashboard/infra/services/verification_requests_service.dart';
import 'package:kira_dashboard/models/coin.dart';
import 'package:kira_dashboard/models/delegation.dart';
import 'package:kira_dashboard/models/identity_records.dart';
import 'package:kira_dashboard/models/transaction.dart';
import 'package:kira_dashboard/models/undelegation.dart';
import 'package:kira_dashboard/models/validator.dart';
import 'package:kira_dashboard/models/verification_request.dart';
import 'package:kira_dashboard/pages/portfolio_page/portfolio_page_state.dart';
import 'package:kira_dashboard/utils/paginated_request.dart';

class PortfolioPageCubit extends Cubit<PortfolioPageState> {
  final BalancesService balancesService = BalancesService();
  final IdentityRegistrarService identityRegistrarService = IdentityRegistrarService();
  final DelegationsService delegationsService = DelegationsService();
  final UndelegationsService undelegationsService = UndelegationsService();
  final VerificationRequestsService verificationRequestsService = VerificationRequestsService();
  final TransactionsService transactionsService = TransactionsService();
  final ValidatorsService validatorsService = ValidatorsService();

  final String address;

  PortfolioPageCubit({
    required this.address,
  }) : super(PortfolioPageState(isLoading: true, isMyWallet: address == getIt<WalletProvider>().value?.address)) {
    getIt<WalletProvider>().addListener(() {
      emit(state.copyWith(isMyWallet: address == getIt<WalletProvider>().value?.address));
    });
  }

  Future<void> init() async {
    PaginatedRequest paginatedRequest = const PaginatedRequest(limit: 20, offset: 0);

    List<Coin> balance = await balancesService.getPage(address, paginatedRequest);
    IdentityRecords identityRecords = await identityRegistrarService.getAllByAddress(address, paginatedRequest);
    List<Delegation> delegations = await delegationsService.getPage(address, paginatedRequest);
    List<Undelegation> undelegations = await undelegationsService.getPage(address, paginatedRequest);
    List<VerificationRequest> inboundVerificationRequests = await verificationRequestsService.getInboundPage(address, paginatedRequest);
    List<VerificationRequest> outboundVerificationRequests = await verificationRequestsService.getOutboundPage(address, paginatedRequest);
    List<Transaction> transactions = await transactionsService.getUserTransactionsPage(address, paginatedRequest);
    Validator? validator = await validatorsService.getById(address);

    emit(state.copyWith(
      isLoading: false,
      balance: balance,
      identityRecords: identityRecords,
      delegations: delegations,
      undelegations: undelegations,
      inboundVerificationRequests: inboundVerificationRequests,
      outboundVerificationRequests: outboundVerificationRequests,
      transactions: transactions,
      validator: validator,
    ));
  }
}
