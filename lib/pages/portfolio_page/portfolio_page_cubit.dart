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
  final IdentityRegistrarService identityRegistrarService = IdentityRegistrarService();
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

    IdentityRecords identityRecords = await identityRegistrarService.getUserProfile(address);
    Validator? validator = await validatorsService.getById(address);

    emit(state.copyWith(
      isLoading: false,
      identityRecords: identityRecords,
      validator: validator,
    ));
  }
}
