import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:kira_dashboard/infra/entities/unsafe_wallet_hive_entity.dart';
import 'package:kira_dashboard/infra/repository/unsafe_wallet_repository.dart';
import 'package:kira_dashboard/models/wallet.dart';

class UnsafeWalletService {
  final UnsafeWalletRepository unsafeWalletRepository = UnsafeWalletRepository();

  Future<void> saveWallet(Wallet wallet) async {
    UnsafeWalletHiveEntity entity = UnsafeWalletHiveEntity(
      index: wallet.index,
      masterPrivateKey: wallet.bip44.privateKey.raw,
      childMasterKey: wallet.derivedBip44.privateKey.raw,
    );
    await unsafeWalletRepository.saveWallet(entity);
  }

  Future<void> deleteWallet(int index) async {
    await unsafeWalletRepository.deleteWallet(index);
  }

  Future<void> deleteAllWallets() async {
    await unsafeWalletRepository.deleteAllWallets();
  }

  Future<Wallet?> getWallet(int index) async {
    UnsafeWalletHiveEntity? entity = await unsafeWalletRepository.getWallet(index);
    if(entity == null) return null;

    Wallet wallet = Wallet(
      index: entity.index,
      bip44: Bip44.fromPrivateKey(entity.masterPrivateKey, KiraBip44Coin()),
      derivedBip44: Bip44.fromPrivateKey(entity.childMasterKey, KiraBip44Coin()),
    );
    return wallet;
  }

  Future<List<Wallet>> getAvailableWallets() async {
    List<UnsafeWalletHiveEntity> entities = await unsafeWalletRepository.getAvailableWallets();
    List<Wallet> wallets = entities.map((e) => Wallet(
      index: e.index,
      bip44: Bip44.fromPrivateKey(e.masterPrivateKey, KiraBip44Coin()),
      derivedBip44: Bip44.fromPrivateKey(e.childMasterKey, KiraBip44Coin()),
    )).toList();
    return wallets;
  }
}