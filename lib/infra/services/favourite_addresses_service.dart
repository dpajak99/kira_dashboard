import 'package:kira_dashboard/infra/entities/favourite_address_entity.dart';
import 'package:kira_dashboard/infra/repository/favourite_addresses_repository.dart';

class FavouriteAddressesService {
  final FavouriteAddressesRepository favouriteAddressesRepository = FavouriteAddressesRepository();

  Future<void> add(String address) async {
    FavouriteAddressHiveEntity addressEntity = FavouriteAddressHiveEntity(
      address: address,
      date: DateTime.now().toString(),
    );
    await favouriteAddressesRepository.save(addressEntity);
  }

  Future<void> remove(String address) async {
    await favouriteAddressesRepository.delete(address);
  }

  Future<List<FavouriteAddressHiveEntity>> getAll() async {
    return await favouriteAddressesRepository.getAll();
  }

  Future<bool> isFavourite(String address) async {
    List<FavouriteAddressHiveEntity> addresses = await favouriteAddressesRepository.getAll();
    return addresses.any((element) => element.address == address);
  }
}
