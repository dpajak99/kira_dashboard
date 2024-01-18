import 'package:equatable/equatable.dart';
import 'package:kira_dashboard/infra/entities/identity_registrar/verification_request_entity.dart';

class QueryVerificationRequestsResponse extends Equatable {
  final List<VerificationRequestEntity> verificationRequests;

  const QueryVerificationRequestsResponse({
    required this.verificationRequests,
  });

  factory QueryVerificationRequestsResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> verificationRequests = json['verify_records'] != null ? json['verify_records'] as List<dynamic> : List<dynamic>.empty();
    return QueryVerificationRequestsResponse(
      verificationRequests: verificationRequests.map((dynamic e) => VerificationRequestEntity.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  @override
  List<Object?> get props => <Object?>[verificationRequests];
}
