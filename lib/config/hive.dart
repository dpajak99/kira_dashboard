import 'package:hive/hive.dart';
import 'package:kira_dashboard/infra/entities/unsafe_wallet_hive_entity.dart';

Future<void> initHive() async {
  Hive.registerAdapter(UnsafeWalletHiveEntityAdapter());

  await Hive.openBox('wallets');
}