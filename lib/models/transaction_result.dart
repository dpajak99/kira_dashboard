import 'package:equatable/equatable.dart';
import 'package:kira_dashboard/infra/entities/transactions/in/types.dart';
import 'package:kira_dashboard/models/coin.dart';

enum TxStatusType {
  confirmed,
  failed,
  pending;

  static TxStatusType fromString(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
      case 'success':
        return TxStatusType.confirmed;
      case 'failed':
      case 'failure':
        return TxStatusType.failed;
      case 'pending':
        return TxStatusType.pending;
      default:
        throw ArgumentError('Invalid TxStatusType: $status');
    }
  }
}

class TransactionResult extends Equatable {
  final String hash;
  final TxStatusType status;
  final int blockHeight;
  final DateTime blockTimestamp;
  final int confirmation;
  final List<TxMsg> msgs;
  final List<dynamic> transactions;
  final List<Coin> fees;
  final String memo;

  const TransactionResult({
    required this.hash,
    required this.status,
    required this.blockHeight,
    required this.blockTimestamp,
    required this.confirmation,
    required this.msgs,
    required this.transactions,
    required this.fees,
    required this.memo,
  });

  @override
  List<Object?> get props => [hash, status, blockHeight, blockTimestamp, confirmation, msgs, transactions, fees, memo];
}
