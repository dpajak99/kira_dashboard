import 'package:kira_dashboard/infra/entities/identity_registrar/identity_record_entity.dart';
import 'package:kira_dashboard/infra/repository/identity_registrar_repository.dart';
import 'package:kira_dashboard/models/identity_records.dart';
import 'package:kira_dashboard/utils/paginated_request.dart';

class IdentityRegistrarService {
  final IdentityRegistrarRepository identityRegistrarRepository = IdentityRegistrarRepository();

  Future<IdentityRecords> getUserProfile(String address) async {
    List<IdentityRecordEntity> identityRecords = await identityRegistrarRepository.getAll(address);
    Map<String, IdentityRecordEntity> identityRecordsMap = <String, IdentityRecordEntity>{};
    for (IdentityRecordEntity identityRecord in identityRecords) {
      identityRecordsMap[identityRecord.key] = identityRecord;
    }

    return IdentityRecords(
      username: identityRecordsMap['username'] != null ? IdentityRecord.fromEntity(identityRecordsMap.remove('username')!) : null,
      moniker: identityRecordsMap['moniker'] != null ? IdentityRecord.fromEntity(identityRecordsMap.remove('moniker')!) : null,
      avatar: identityRecordsMap['avatar'] != null ? IdentityRecord.fromEntity(identityRecordsMap.remove('avatar')!) : null,
      description: identityRecordsMap['description'] != null ? IdentityRecord.fromEntity(identityRecordsMap.remove('description')!) : null,
      social: identityRecordsMap['social'] != null ? IdentityRecord.fromEntity(identityRecordsMap.remove('social')!) : null,
      other: identityRecordsMap.values.map((IdentityRecordEntity e) => IdentityRecord.fromEntity(e)).toList(),
    );
  }

  Future<List<IdentityRecord>> getAll(String address) async {
    List<IdentityRecordEntity> identityRecords = await identityRegistrarRepository.getAll(address);
    return identityRecords.map((IdentityRecordEntity e) => IdentityRecord.fromEntity(e)).toList();
  }

  Future<List<IdentityRecord>> getByIds(List<String> ids) async {
    return Future.wait(ids.map((String id) async {
      return await getById(id);
    }));
  }

  Future<IdentityRecord> getById(String id) async {
    IdentityRecordEntity identityRecordEntity = await identityRegistrarRepository.getById(id);
    return IdentityRecord.fromEntity(identityRecordEntity);
  }
}
