import 'package:flutter/cupertino.dart';
import 'package:kira_dashboard/infra/services/balances_service.dart';
import 'package:kira_dashboard/models/coin.dart';
import 'package:kira_dashboard/models/paginated_list_wrapper.dart';
import 'package:kira_dashboard/utils/cubits/list_cubit/infinity_list_cubit.dart';
import 'package:kira_dashboard/utils/paginated_request.dart';

class SelectTokenDialogCubit extends InfinityListCubit<Coin> {
  final String address;
  final BalancesService balancesService = BalancesService();

  SelectTokenDialogCubit({
    required super.scrollController,
    required this.address,
  }) : super(const InfinityListState.loading());

  @override
  Future<PaginatedListWrapper<Coin>> getPage(PaginatedRequest paginatedRequest) {
    return balancesService.getPage(address, paginatedRequest);
  }
}
