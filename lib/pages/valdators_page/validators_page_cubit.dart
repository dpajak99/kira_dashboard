import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/config/wallet_provider.dart';
import 'package:kira_dashboard/infra/services/validators_service.dart';
import 'package:kira_dashboard/models/validator.dart';
import 'package:kira_dashboard/pages/valdators_page/validators_page_state.dart';

class ValidatorsPageCubit extends Cubit<ValidatorsPageState> {
  final WalletProvider walletProvider = getIt<WalletProvider>();
  final ValidatorsService validatorsService = ValidatorsService();

  ValidatorsPageCubit()
      : super(ValidatorsPageState(
          isLoading: true,
          isSignedIn: getIt<WalletProvider>().isSignedIn,
        )) {
    walletProvider.addListener(() {
      print('Notified');
      emit(state.copyWith(isSignedIn: walletProvider.isSignedIn));
    });
  }

  Future<void> init() async {
    List<Validator> validators = await validatorsService.getAll();

    emit(state.copyWith(
      isLoading: false,
      validators: validators,
    ));
  }
}
