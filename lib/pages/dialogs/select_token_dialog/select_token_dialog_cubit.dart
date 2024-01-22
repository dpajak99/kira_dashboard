import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/infra/services/balances_service.dart';
import 'package:kira_dashboard/models/coin.dart';
import 'package:kira_dashboard/pages/dialogs/select_token_dialog/select_token_dialog_state.dart';
import 'package:kira_dashboard/utils/paginated_request.dart';

class SelectTokenDialogCubit extends Cubit<SelectTokenDialogState> {
  final String address;
  final BalancesService balancesService = BalancesService();

  SelectTokenDialogCubit({
    required this.address,
  }) : super(const SelectTokenDialogState(balances: [])) {
    init();
  }

  Future<void> init() async {
    PaginatedRequest paginatedRequest = const PaginatedRequest(limit: 20, offset: 0);

    List<Coin> balances = await balancesService.getPage(address, paginatedRequest);
    emit(SelectTokenDialogState(balances: balances));
  }
}
