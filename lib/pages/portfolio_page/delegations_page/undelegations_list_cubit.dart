import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/infra/services/delegations_service.dart';
import 'package:kira_dashboard/infra/services/undelegations_service.dart';
import 'package:kira_dashboard/models/delegation.dart';
import 'package:kira_dashboard/models/undelegation.dart';
import 'package:kira_dashboard/pages/portfolio_page/delegations_page/delegations_list_state.dart';
import 'package:kira_dashboard/pages/portfolio_page/delegations_page/undelegations_list_state.dart';
import 'package:kira_dashboard/utils/paginated_request.dart';

class UndelegationsListCubit extends Cubit<UndelegationsListState> {
  final UndelegationsService undelegationsService = UndelegationsService();

  final String address;
  final bool isMyWallet;

  UndelegationsListCubit({
    required this.address,
    required this.isMyWallet,
  }) : super(const UndelegationsListState(isLoading: true)) {
    _init();
  }

  Future<void> _init() async {
    PaginatedRequest paginatedRequest = const PaginatedRequest(limit: 20, offset: 0);
    List<Undelegation> undelegations = await undelegationsService.getPage(address, paginatedRequest);

    emit(state.copyWith(isLoading: false, undelegations: undelegations));
  }
}