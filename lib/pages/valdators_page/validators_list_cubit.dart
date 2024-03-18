import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/config/wallet_provider.dart';
import 'package:kira_dashboard/infra/services/validators_service.dart';
import 'package:kira_dashboard/models/paginated_list_wrapper.dart';
import 'package:kira_dashboard/models/validator.dart';
import 'package:kira_dashboard/utils/cubits/list_cubit/list_cubit.dart';
import 'package:kira_dashboard/utils/paginated_request.dart';

class ValidatorsListCubit extends PaginatedListCubit<Validator> {
  final WalletProvider walletProvider = getIt<WalletProvider>();
  final ValidatorsService validatorsService = ValidatorsService();

  ValidatorsListCubit() : super(const PaginatedListState.loading());

  @override
  Future<PaginatedListWrapper<Validator>> getPage(PaginatedRequest paginatedRequest) {
    return validatorsService.getPage(paginatedRequest);
  }
}
