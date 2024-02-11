import 'package:kira_dashboard/infra/entities/favourite_address_entity.dart';
import 'package:kira_dashboard/infra/entities/identity_registrar/identity_record_entity.dart';
import 'package:kira_dashboard/infra/repository/identity_registrar_repository.dart';
import 'package:kira_dashboard/infra/services/favourite_addresses_service.dart';
import 'package:kira_dashboard/models/identity_records.dart';

class IdentityRegistrarService {
  final IdentityRegistrarRepository identityRegistrarRepository = IdentityRegistrarRepository();
  final FavouriteAddressesService favouriteAddressesService = FavouriteAddressesService();

  Future<IdentityRecords> getUserProfile(String address) async {
    List<IdentityRecordEntity> identityRecords = await identityRegistrarRepository.getAll(address);
    List<FavouriteAddressHiveEntity> allTrustedVerifiers = await favouriteAddressesService.getAll();

    List<IdentityRecord> records = identityRecords.map((IdentityRecordEntity e) => IdentityRecord(
      id: e.id,
      key: e.key,
      value: e.value,
      verifiers: e.verifiers,
      trustedVerifiers: allTrustedVerifiers.where((FavouriteAddressHiveEntity a) => e.verifiers.contains(a.address)).map((FavouriteAddressHiveEntity a) => a.address).toList(),
    )).toList();

    return IdentityRecords(
      username: records.where((IdentityRecord e) => e.key == 'username').firstOrNull,
      moniker: records.where((IdentityRecord e) => e.key == 'moniker').firstOrNull,
      avatar: records.where((IdentityRecord e) => e.key == 'avatar').firstOrNull ?? records.where((IdentityRecord e) => e.key == 'logo').firstOrNull,
      description: records.where((IdentityRecord e) => e.key == 'description').firstOrNull,
      social: records.where((IdentityRecord e) => e.key == 'social').firstOrNull,
      other: records.where((IdentityRecord e) => e.key != 'username' && e.key != 'moniker' && e.key != 'avatar' && e.key != 'description' && e.key != 'social').toList(),
    );
  }

  Future<List<IdentityRecord>> getAll(String address) async {
    List<IdentityRecordEntity> identityRecords = await identityRegistrarRepository.getAll(address);
    List<FavouriteAddressHiveEntity> allTrustedVerifiers = await favouriteAddressesService.getAll();

    return identityRecords.map((IdentityRecordEntity e) => IdentityRecord(
      id: e.id,
      key: e.key,
      value: e.value,
      verifiers: e.verifiers,
      trustedVerifiers: allTrustedVerifiers.where((FavouriteAddressHiveEntity a) => e.verifiers.contains(a.address)).map((FavouriteAddressHiveEntity a) => a.address).toList(),
    )).toList();
  }

  Future<List<IdentityRecord>> getByIds(List<String> ids) async {
    return Future.wait(ids.map((String id) async {
      return await getById(id);
    }));
  }

  Future<IdentityRecord> getById(String id) async {
    IdentityRecordEntity identityRecordEntity = await identityRegistrarRepository.getById(id);
    List<FavouriteAddressHiveEntity> allTrustedVerifiers = await favouriteAddressesService.getAll();

     return IdentityRecord(
        id: identityRecordEntity.id,
        key: identityRecordEntity.key,
        value: identityRecordEntity.value,
        verifiers: identityRecordEntity.verifiers,
       trustedVerifiers: allTrustedVerifiers.where((FavouriteAddressHiveEntity a) => identityRecordEntity.verifiers.contains(a.address)).map((FavouriteAddressHiveEntity a) => a.address).toList(),
      );
  }
}
