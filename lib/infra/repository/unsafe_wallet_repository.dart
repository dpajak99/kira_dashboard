import 'package:hive/hive.dart';
import 'package:kira_dashboard/infra/entities/unsafe_wallet_hive_entity.dart';

class UnsafeWalletRepository {
  Future<void> saveWallet(UnsafeWalletHiveEntity wallet) async {
    Box box = Hive.box('wallets');
    await box.put("${wallet.index}", wallet);
  }

  Future<void> deleteWallet(int index) async {
    Box box = Hive.box('wallets');
    await box.delete("$index");
  }

  Future<void> deleteAllWallets() async {
    Box box = Hive.box('wallets');
    await box.clear();
  }

  Future<UnsafeWalletHiveEntity?> getWallet(int index) async {
    Box box = Hive.box('wallets');
    return await box.get("$index");
  }

  Future<List<UnsafeWalletHiveEntity>> getAvailableWallets() async {
    Box box = Hive.box('wallets');
    return box.values.toList().cast<UnsafeWalletHiveEntity>();
  }
}