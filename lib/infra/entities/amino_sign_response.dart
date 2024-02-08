import 'package:equatable/equatable.dart';
import 'package:kira_dashboard/infra/entities/transactions/out/transaction/std_sign_doc.dart';

class AminoSignResponse extends Equatable {
  final StdSignDoc signed;
  final Signature signature;

  const AminoSignResponse({
    required this.signed,
    required this.signature,
  });

  AminoSignResponse.fromJson(Map<String, dynamic> json)
      : signed = StdSignDoc.fromJson(json['signed']),
        signature = Signature.fromJson(json['signature']);

  @override
  List<Object?> get props => [signed, signature];
}

class Signature extends Equatable {
  final String signature;

  const Signature({
    required this.signature,
  });

  Signature.fromJson(Map<String, dynamic> json) : signature = json['signature'];

  @override
  List<Object?> get props => [signature];
}
