import 'package:hive/hive.dart';
import 'package:kira_dashboard/infra/entities/favourite_address_entity.dart';

class FavouriteAddressesRepository {
  Future<void> save(FavouriteAddressHiveEntity favouriteAddressHiveEntity) async {
    Box box = Hive.box('fav_addresses');
    await box.put(favouriteAddressHiveEntity.address, favouriteAddressHiveEntity);
  }

  Future<void> delete(String address) async {
    Box box = Hive.box('fav_addresses');
    await box.delete(address);
  }

  Future<List<FavouriteAddressHiveEntity>> getAll() async {
    Box box = Hive.box('fav_addresses');
    return box.values.toList().cast<FavouriteAddressHiveEntity>();
  }
}