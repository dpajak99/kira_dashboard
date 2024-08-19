import 'package:hive/hive.dart';

part 'unsafe_wallet_hive_entity.g.dart';

@HiveType(typeId: 0)
class UnsafeWalletHiveEntity extends HiveObject {
  @HiveField(0)
  final String extendedMasterKey;

  @HiveField(1)
  final int index;

  UnsafeWalletHiveEntity({
    required this.extendedMasterKey,
    required this.index,
  });
}
