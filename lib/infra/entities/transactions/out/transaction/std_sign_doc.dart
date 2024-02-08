import 'package:equatable/equatable.dart';
import 'package:kira_dashboard/infra/entities/transactions/in/types.dart';
import 'package:kira_dashboard/infra/entities/transactions/out/transaction/components/tx_fee.dart';

/// StdSignDoc is replay-prevention structure.
///
/// https://docs.cosmos.network/master/core/transactions.html
class StdSignDoc extends Equatable {
  /// The account number of the account in state
  final String accountNumber;

  /// Sequence of the account, which describes the number
  /// of committed transactions signed by a given address.
  /// It is used to prevent replay attacks.
  final String sequence;

  /// The unique identifier of the chain this transaction targets.
  /// It prevents signed transactions from being used on another chain by an attacker
  final String chainId;

  /// Any arbitrary note/comment to be added to the transaction.
  final String memo;

  /// Fee includes the amount of coins paid in fees to be used by the transaction.
  final TxFee fee;

  /// List of messages to be executed.
  final List<TxMsg> messages;

  const StdSignDoc({
    required this.accountNumber,
    required this.sequence,
    required this.chainId,
    required this.memo,
    required this.fee,
    required this.messages,
  });

  factory StdSignDoc.fromJson(Map<String, dynamic> json) {
    return StdSignDoc(
      accountNumber: json['account_number'],
      sequence: json['sequence'],
      chainId: json['chain_id'],
      memo: json['memo'],
      fee: TxFee.fromJson(json['fee']),
      messages: (json['msgs'] as List<dynamic>).map((dynamic e) => TxMsg.fromJsonByName(e['type'], e['value'])).toList(),
    );
  }

  Map<String, dynamic> toSignatureJson() {
    return <String, dynamic>{
      'account_number': accountNumber,
      'sequence': sequence,
      'chain_id': chainId,
      'memo': memo,
      'fee': fee.toSignatureJson(),
      'msgs': messages.map((TxMsg txMsg) => txMsg.toSignatureJson()).toList(),
    };
  }

  @override
  List<Object?> get props => <Object?>[accountNumber, sequence, chainId, memo, fee, messages];
}
