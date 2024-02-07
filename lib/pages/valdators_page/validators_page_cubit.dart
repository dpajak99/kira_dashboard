import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/config/wallet_provider.dart';
import 'package:kira_dashboard/infra/services/validators_service.dart';
import 'package:kira_dashboard/models/validator.dart';
import 'package:kira_dashboard/pages/valdators_page/validators_page_state.dart';
import 'package:kira_dashboard/utils/cubits/list_cubit/refreshable_page_cubit.dart';

class ValidatorsPageCubit extends RefreshablePageCubit<ValidatorsPageState> {
  final WalletProvider walletProvider = getIt<WalletProvider>();
  final ValidatorsService validatorsService = ValidatorsService();

  ValidatorsPageCubit()
      : super(ValidatorsPageState(
          isLoading: true,
          isSignedIn: getIt<WalletProvider>().isSignedIn,
        )) {
    walletProvider.addListener(() {
      emit(state.copyWith(isSignedIn: walletProvider.isSignedIn));
    });
  }

  @override
  Future<void> reload() async {
    emit(ValidatorsPageState(isLoading: true, isSignedIn: getIt<WalletProvider>().isSignedIn));

    List<Validator> validators = await validatorsService.getAll();

    emit(state.copyWith(
      isLoading: false,
      validators: validators,
    ));
  }
}
