import 'package:equatable/equatable.dart';
import 'package:kira_dashboard/infra/entities/transactions/out/transaction/tx.dart';

class BroadcastReq extends Equatable {
  final Tx tx;
  final String mode;

  const BroadcastReq({
    required this.tx,
    this.mode = 'block',
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'tx': tx.toJson(),
      'mode': mode,
    };
  }

  @override
  List<Object?> get props => <Object?>[tx, mode];
}
