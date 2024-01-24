import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/infra/services/balances_service.dart';
import 'package:kira_dashboard/models/coin.dart';
import 'package:kira_dashboard/pages/dialogs/widgets/token_amount_text_field/token_amount_text_field_state.dart';

class TokenAmountTextFieldCubit extends Cubit<TokenAmountTextFieldState> {
  final BalancesService balancesService = BalancesService();
  final String address;

  TokenAmountTextFieldCubit.fromBalance(this.address, Coin balance) : super(TokenAmountTextFieldState.fromBalance(balance));

  void selectToken(Coin coin) {
    emit(TokenAmountTextFieldState.fromBalance(coin));
  }
}
