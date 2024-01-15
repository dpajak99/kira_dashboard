import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/infra/services/balances_service.dart';
import 'package:kira_dashboard/infra/services/delegations_service.dart';
import 'package:kira_dashboard/infra/services/identity_registrar_service.dart';
import 'package:kira_dashboard/infra/services/undelegations_service.dart';
import 'package:kira_dashboard/models/coin.dart';
import 'package:kira_dashboard/models/delegation.dart';
import 'package:kira_dashboard/models/identity_records.dart';
import 'package:kira_dashboard/models/undelegation.dart';
import 'package:kira_dashboard/pages/portfolio_page/portfolio_page_state.dart';

class PortfolioPageCubit extends Cubit<PortfolioPageState> {
  final BalancesService balancesService = BalancesService();
  final IdentityRegistrarService identityRegistrarService = IdentityRegistrarService();
  final DelegationsService delegationsService = DelegationsService();
  final UndelegationsService undelegationsService = UndelegationsService();

  final String address;

  PortfolioPageCubit({
    required this.address,
  }) : super(PortfolioPageState(isLoading: true));

  Future<void> init() async {
    List<Coin> balance = await balancesService.getAll(address);
    IdentityRecords identityRecords = await identityRegistrarService.getAllByAddress(address);
    List<Delegation> delegations = await delegationsService.getAll(address);
    List<Undelegation> undelegations = await undelegationsService.getAll(address);

    emit(PortfolioPageState(
      isLoading: false,
      balance: balance,
      identityRecords: identityRecords,
      delegations: delegations,
      undelegations: undelegations,
    ));
  }
}
