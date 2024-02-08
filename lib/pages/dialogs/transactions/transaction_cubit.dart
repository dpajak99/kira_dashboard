import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/config/wallet_provider.dart';
import 'package:kira_dashboard/models/wallet.dart';
import 'package:kira_dashboard/utils/user_transactions.dart';

mixin TransactionMixin {
  final WalletProvider _walletProvider = getIt<WalletProvider>();

  UserTransactions get txClient {
    return UserTransactions(
      txProcessNotificator: DialogTxProcessNotificator(),
      signerAddress: signerAddress,
      compressedPublicKey: signerPublicKey,
      txSigner:_walletProvider.value is KeplrWallet ? KeplrWalletSigner() : UnsafeWalletSigner(),
    );
  }

  String get signerAddress => _walletProvider.value!.address;

  List<int> get signerPublicKey => _walletProvider.value!.publicKey;
}
