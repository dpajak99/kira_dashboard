import 'package:hive/hive.dart';

part 'unsafe_wallet_hive_entity.g.dart';

@HiveType(typeId: 0)
class UnsafeWalletHiveEntity extends HiveObject {
  @HiveField(0)
  final List<int> masterPrivateKey;

  @HiveField(1)
  final List<int> childMasterKey;

  @HiveField(2)
  final int index;

  UnsafeWalletHiveEntity({
    required this.index,
    required this.masterPrivateKey,
    required this.childMasterKey,
  });
}
