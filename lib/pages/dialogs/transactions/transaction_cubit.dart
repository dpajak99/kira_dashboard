import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/config/wallet_provider.dart';
import 'package:kira_dashboard/utils/user_transactions.dart';

abstract class TransactionCubit<T> extends Cubit<T> {
  final WalletProvider _walletProvider = WalletProvider();

  TransactionCubit(super.initialState);

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

  @override
  void emit(T state) {
    if(isClosed) return;
    super.emit(state);
  }
}