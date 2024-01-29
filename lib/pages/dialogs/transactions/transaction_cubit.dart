import 'package:kira_dashboard/config/wallet_provider.dart';
import 'package:kira_dashboard/utils/user_transactions.dart';
 
mixin TransactionMixin {
  final WalletProvider _walletProvider = WalletProvider();

  UserTransactions get txClient {
    return UserTransactions(
      txProcessNotificator: DialogTxProcessNotificator(),
      signerAddress: signerAddress,
      compressedPublicKey: signerPublicKey,
      txSigner: UnsafeWalletSigner(),
    );
  }

  String get signerAddress => _walletProvider.value!.address;

  List<int> get signerPublicKey => _walletProvider.value!.derivedBip44.publicKey.compressed;
}