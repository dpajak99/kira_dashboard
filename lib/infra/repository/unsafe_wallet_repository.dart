import 'package:hive/hive.dart';
import 'package:kira_dashboard/infra/entities/unsafe_wallet_hive_entity.dart';

class UnsafeWalletRepository {
  Future<void> saveWallet(UnsafeWalletHiveEntity wallet) async {
    Box box = Hive.box('wallets');
    await box.put("unsafe_wallet", wallet);
  }

  Future<UnsafeWalletHiveEntity?> getWallet() async {
    Box box = Hive.box('wallets');
    return await box.get("unsafe_wallet");
  }
}