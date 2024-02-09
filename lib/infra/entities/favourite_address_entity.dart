import 'package:hive/hive.dart';

part 'favourite_address_entity.g.dart';

@HiveType(typeId: 1)
class FavouriteAddressHiveEntity extends HiveObject {
  @HiveField(0)
  final String address;

  @HiveField(1)
  final String date;

  FavouriteAddressHiveEntity({
    required this.address,
    required this.date,
  });
}
