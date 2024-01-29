import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/config/wallet_provider.dart';
import 'package:kira_dashboard/infra/services/identity_registrar_service.dart';
import 'package:kira_dashboard/infra/services/validators_service.dart';
import 'package:kira_dashboard/models/identity_records.dart';
import 'package:kira_dashboard/models/validator.dart';
import 'package:kira_dashboard/pages/portfolio_page/portfolio_page_state.dart';
import 'package:kira_dashboard/utils/cubits/list_cubit/refreshable_page_cubit.dart';

class PortfolioPageCubit extends RefreshablePageCubit<PortfolioPageState> {
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

  @override
  Future<void> reload() async {
    emit(PortfolioPageState(isLoading: true, isMyWallet: address == getIt<WalletProvider>().value?.address));

    IdentityRecords identityRecords = await identityRegistrarService.getUserProfile(address);
    Validator? validator = await validatorsService.getById(address);

    emit(state.copyWith(
      isLoading: false,
      identityRecords: identityRecords,
      validator: validator,
    ));
  }
}
