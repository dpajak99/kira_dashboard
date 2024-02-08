import 'package:kira_dashboard/models/wallet.dart';
import 'package:kira_dashboard/pages/dialogs/account_dialog/wallet_info.dart';
import 'package:kira_dashboard/pages/page_state.dart';

class AccountDialogState extends PageState {
  final IWallet? selectedWallet;
  final List<WalletInfo> walletInfos;

  const AccountDialogState({
    this.selectedWallet,
    this.walletInfos = const [],
    required super.isLoading,
  });

  AccountDialogState copyWith({
    IWallet? selectedWallet,
    List<WalletInfo>? walletInfos,
    bool? isLoading,
  }) {
    return AccountDialogState(
      selectedWallet: selectedWallet ?? this.selectedWallet,
      walletInfos: walletInfos ?? this.walletInfos,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [selectedWallet, walletInfos, isLoading];
}
