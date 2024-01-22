import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:kira_dashboard/infra/entities/unsafe_wallet_hive_entity.dart';
import 'package:kira_dashboard/infra/repository/unsafe_wallet_repository.dart';
import 'package:kira_dashboard/models/wallet.dart';

class UnsafeWalletService {
  final UnsafeWalletRepository unsafeWalletRepository = UnsafeWalletRepository();

  Future<void> saveWallet(Wallet wallet) async {
    UnsafeWalletHiveEntity entity = UnsafeWalletHiveEntity(
      masterPrivateKey: wallet.bip44.privateKey.raw,
      childMasterKey: wallet.derivedBip44.privateKey.raw,
    );
    await unsafeWalletRepository.saveWallet(entity);
  }

  Future<Wallet?> getWallet() async {
    UnsafeWalletHiveEntity? entity = await unsafeWalletRepository.getWallet();
    if(entity == null) return null;

    Wallet wallet = Wallet(
      bip44: Bip44.fromPrivateKey(entity.masterPrivateKey, KiraBip44Coin()),
      derivedBip44: Bip44.fromPrivateKey(entity.childMasterKey, KiraBip44Coin()),
    );
    return wallet;
  }
}