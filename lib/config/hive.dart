import 'package:hive/hive.dart';
import 'package:kira_dashboard/infra/entities/favourite_address_entity.dart';
import 'package:kira_dashboard/infra/entities/unsafe_wallet_hive_entity.dart';

Future<void> initHive() async {
  Hive.registerAdapter(UnsafeWalletHiveEntityAdapter());
  Hive.registerAdapter(FavouriteAddressHiveEntityAdapter());

  await Hive.openBox('wallets');
  await Hive.openBox('fav_addresses');
}