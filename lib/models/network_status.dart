import 'package:equatable/equatable.dart';

class NetworkStatus extends Equatable {
  final int block;
  final String chainId;
  final String hash;
  final String requestHash;
  final String signature;
  final int timestamp;
  final DateTime blockDateTime;

  const NetworkStatus({
    required this.block,
    required this.chainId,
    required this.hash,
    required this.requestHash,
    required this.signature,
    required this.timestamp,
    required this.blockDateTime,
  });

  @override
  List<Object?> get props => <Object?>[block, chainId, hash, requestHash, signature, timestamp, blockDateTime];
}
