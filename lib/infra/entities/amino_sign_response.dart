import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:equatable/equatable.dart';

class AminoSignResponse extends Equatable {
  final CosmosSignDoc signed;
  final CosmosSignature signature;

  const AminoSignResponse({
    required this.signed,
    required this.signature,
  });

  factory AminoSignResponse.fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }

  @override
  List<Object?> get props => [signed, signature];
}