import 'package:dio/browser.dart';
import 'package:dio/dio.dart';
import 'package:kira_dashboard/infra/entities/identity_registrar/identity_record_entity.dart';
import 'package:kira_dashboard/infra/entities/identity_registrar/query_identity_record_response.dart';
import 'package:kira_dashboard/infra/entities/identity_registrar/query_identity_records_response.dart';

class IdentityRegistrarRepository {
  final Dio httpClient = DioForBrowser(BaseOptions(
    baseUrl: 'http://65.108.86.252:11000/',
  ));

  Future<List<IdentityRecordEntity>> getAllByAddress(String address) async {
    Response<Map<String, dynamic>> response = await httpClient.get('/api/kira/gov/identity_records/$address');
    QueryIdentityRecordsResponse queryIdentityRecordsResponse = QueryIdentityRecordsResponse.fromJson(response.data!);

    return queryIdentityRecordsResponse.records;
  }

  Future<IdentityRecordEntity> getById(String id) async {
    Response<Map<String, dynamic>> response = await httpClient.get('/api/kira/gov/identity_record/$id');
    QueryIdentityRecordResponse queryIdentityRecordResponse = QueryIdentityRecordResponse.fromJson(response.data!);

    return queryIdentityRecordResponse.identityRecord;
  }
}
