import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:kira_dashboard/infra/entities/unsafe_wallet_hive_entity.dart';
import 'package:kira_dashboard/infra/repository/unsafe_wallet_repository.dart';
import 'package:kira_dashboard/models/wallet.dart';

class UnsafeWalletService {
  final UnsafeWalletRepository unsafeWalletRepository = UnsafeWalletRepository();

  Future<void> saveWallet(Wallet wallet) async {
    UnsafeWalletHiveEntity entity = UnsafeWalletHiveEntity(
      index: wallet.index,
      extendedMasterKey: wallet.masterPrivateKey.getExtendedPrivateKey(),
    );
    await unsafeWalletRepository.saveWallet(entity);
  }

  Future<void> deleteWallet(int index) async {
    await unsafeWalletRepository.deleteWallet(index);
  }

  Future<void> deleteAllWallets() async {
    await unsafeWalletRepository.deleteAllWallets();
  }

  Future<Wallet?> getWallet(int addressIndex) async {
    UnsafeWalletHiveEntity? entity = await unsafeWalletRepository.getWallet(addressIndex);
    if(entity == null) return null;

    Wallet wallet = Wallet.fromMasterPrivateKey(
      addressIndex: entity.index,
      masterPrivateKey: Secp256k1PrivateKey.fromExtendedPrivateKey(entity.extendedMasterKey),
    );
    return wallet;
  }

  Future<List<Wallet>> getAvailableWallets() async {
    List<UnsafeWalletHiveEntity> entities = await unsafeWalletRepository.getAvailableWallets();
    List<Wallet> wallets = entities.map((e) => Wallet.fromMasterPrivateKey(
      addressIndex: e.index,
      masterPrivateKey: Secp256k1PrivateKey.fromExtendedPrivateKey(e.extendedMasterKey),
    )).toList();
    return wallets;
  }
}