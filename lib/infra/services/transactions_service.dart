import 'package:kira_dashboard/infra/entities/balances/coin_entity.dart';
import 'package:kira_dashboard/infra/entities/transactions/in/transaction_entity.dart';
import 'package:kira_dashboard/infra/entities/transactions/in/types.dart';
import 'package:kira_dashboard/infra/repository/transactions_repository.dart';
import 'package:kira_dashboard/infra/services/tokens_service.dart';
import 'package:kira_dashboard/models/coin.dart';
import 'package:kira_dashboard/models/transaction.dart';
import 'package:kira_dashboard/utils/custom_date_utils.dart';

class TransactionsService {
  final TransactionsRepository transactionsRepository = TransactionsRepository();
  final TokensService tokensService = TokensService();

  Future<List<Transaction>> getAll(String address) async {
    List<TransactionEntity> transactionEntities = await transactionsRepository.getAll(address);

    List<Transaction> transactions = await Future.wait<Transaction>(transactionEntities.map((TransactionEntity transactionEntity) async {
      Map<String, dynamic>? msgJson = transactionEntity.txs.firstOrNull;
      TxMsg? txMsg = msgJson != null ? TxMsg.fromJsonByName(msgJson['type'], msgJson) : null;

      List<CoinEntity> amounts = <CoinEntity>[...(txMsg?.txAmounts ?? <CoinEntity>[])];
      List<SimpleCoin> coins = amounts.map((e) => SimpleCoin(amount: e.amount, denom: e.denom)).toList();

      return Transaction(
        time: CustomDateUtils.buildDateFromSecondsSinceEpoch(transactionEntity.time),
        hash: transactionEntity.hash,
        status: transactionEntity.status,
        direction: transactionEntity.direction,
        fee: await tokensService.buildCoins(transactionEntity.fee.map((e) => SimpleCoin(amount: e.amount, denom: e.denom)).toList()),
        amounts: await tokensService.buildCoins(coins),
        from: txMsg?.from,
        to: txMsg?.to,
        method: txMsg.runtimeType.toString(),
      );
    }));

    return transactions;
  }
}
