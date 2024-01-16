import 'package:kira_dashboard/infra/entities/identity_registrar/verification_request_entity.dart';
import 'package:kira_dashboard/infra/repository/verification_requests_repository.dart';
import 'package:kira_dashboard/infra/services/identity_registrar_service.dart';
import 'package:kira_dashboard/infra/services/tokens_service.dart';
import 'package:kira_dashboard/models/coin.dart';
import 'package:kira_dashboard/models/verification_request.dart';

class VerificationRequestsService {
  final TokensService tokensService = TokensService();
  final IdentityRegistrarService identityRegistrarService = IdentityRegistrarService();
  final VerificationRequestsRepository verificationRequestsRepository = VerificationRequestsRepository();

  Future<List<VerificationRequest>> getAllInbound(String address) async {
    List<VerificationRequestEntity> verificationRequestEntities = await verificationRequestsRepository.getAllInbound(address);
    return parseEntities(verificationRequestEntities);
  }

  Future<List<VerificationRequest>> getAllOutbound(String address) async {
    List<VerificationRequestEntity> verificationRequestEntities = await verificationRequestsRepository.getAllOutbound(address);
    return parseEntities(verificationRequestEntities);
  }

  Future<List<VerificationRequest>> parseEntities(List<VerificationRequestEntity> entities) async {
    return await Future.wait<VerificationRequest>(entities.map((VerificationRequestEntity verificationRequestEntity) async {
      return VerificationRequest(
        id: verificationRequestEntity.id,
        address: verificationRequestEntity.address,
        lastRecordEditDate: DateTime.parse(verificationRequestEntity.lastRecordEditDate),
        records: await identityRegistrarService.getByIds(verificationRequestEntity.recordIds),
        tip: await tokensService.buildCoin(SimpleCoin.fromString(verificationRequestEntity.tip)),
        verifier: verificationRequestEntity.verifier,
      );
    }));
  }
}