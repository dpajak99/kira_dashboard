import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/infra/entities/account/account_entity.dart';
import 'package:kira_dashboard/infra/entities/balances/coin_entity.dart';
import 'package:kira_dashboard/infra/entities/fees/fee_config_entity.dart';
import 'package:kira_dashboard/infra/entities/network/headers_wrapper.dart';
import 'package:kira_dashboard/infra/entities/network/network_properties_entity.dart';
import 'package:kira_dashboard/infra/entities/paginated_response_wrapper.dart';
import 'package:kira_dashboard/infra/entities/tokens/aliases/token_alias_entity.dart';
import 'package:kira_dashboard/infra/entities/transactions/block_transaction_entity.dart';
import 'package:kira_dashboard/infra/entities/transactions/broadcast_response.dart';
import 'package:kira_dashboard/infra/entities/transactions/in/transaction_entity.dart';
import 'package:kira_dashboard/infra/entities/transactions/in/types.dart';
import 'package:kira_dashboard/infra/entities/transactions/out/broadcast_req.dart';
import 'package:kira_dashboard/infra/entities/transactions/transaction_result_entity.dart';
import 'package:kira_dashboard/infra/repository/accounts_repository.dart';
import 'package:kira_dashboard/infra/repository/fees_repository.dart';
import 'package:kira_dashboard/infra/repository/network_repository.dart';
import 'package:kira_dashboard/infra/repository/token_aliases_repository.dart';
import 'package:kira_dashboard/infra/repository/transactions_repository.dart';
import 'package:kira_dashboard/infra/services/tokens_service.dart';
import 'package:kira_dashboard/models/block_transaction.dart';
import 'package:kira_dashboard/models/coin.dart';
import 'package:kira_dashboard/models/paginated_list_wrapper.dart';
import 'package:kira_dashboard/models/transaction.dart';
import 'package:kira_dashboard/models/transaction_remote_data.dart';
import 'package:kira_dashboard/models/transaction_result.dart';
import 'package:kira_dashboard/pages/dialogs/network_dialog/network_cubit.dart';
import 'package:kira_dashboard/utils/custom_date_utils.dart';
import 'package:kira_dashboard/utils/paginated_request.dart';

class TransactionsService {
  final NetworkCubit networkCubit = getIt<NetworkCubit>();
  final NetworkRepository networkRepository = NetworkRepository();
  final FeesRepository feesRepository = FeesRepository();
  final AccountsRepository accountsRepository = AccountsRepository();
  final TransactionsRepository transactionsRepository = TransactionsRepository();
  final TokenAliasesRepository tokenAliasesRepository = TokenAliasesRepository();
  final TokensService tokensService = TokensService();

  Future<String> broadcastTx(BroadcastReq broadcastReq) async {
    BroadcastResponse response = await transactionsRepository.broadcastTransaction(broadcastReq.toJson());
    return response.hash;
  }

  Future<Coin> getExecutionFeeForMessage(String message) async {
    String defaultTokenDenom = networkCubit.state.defaultDenom;

    try {
      FeeConfigEntity feeConfigEntity = await feesRepository.getFee(message);
      return tokensService.buildCoin(SimpleCoin(amount: feeConfigEntity.executionFee, denom: defaultTokenDenom));
    } catch (e) {
      NetworkPropertiesEntity networkPropertiesEntity = await networkRepository.getNetworkProperties();
      return tokensService.buildCoin(SimpleCoin(amount: networkPropertiesEntity.minTxFee, denom: defaultTokenDenom));
    }
  }

  Future<TransactionRemoteData> getRemoteUserTransactionData(String address) async {
    HeadersWrapper<AccountEntity> accountEntity = await accountsRepository.getWithHeaders(address);

    return TransactionRemoteData(
      accountNumber: accountEntity.data.accountNumber,
      sequence: accountEntity.data.sequence,
      chainId: accountEntity.headers.chainId,
    );
  }

  Future<PaginatedListWrapper<Transaction>> getUserTransactionsPage(String address, PaginatedRequest paginatedRequest) async {
    PaginatedResponseWrapper<TransactionEntity> response = await transactionsRepository.getUserTransactionsPage(address, paginatedRequest);

    Set<String> allDenominations = response.items.expand((TransactionEntity tx) => tx.allDenominations).toSet();
    Map<String, TokenAliasEntity> tokenAliases = await tokenAliasesRepository.getByTokensNameAsMap(allDenominations.toList());

    List<Transaction> transactions = await Future.wait<Transaction>(response.items.map((TransactionEntity entity) async {
      TxMsg? txMsg = entity.txs.firstOrNull;

      List<CoinEntity> amountEntities = <CoinEntity>[...(txMsg?.txAmounts ?? <CoinEntity>[])];
      List<SimpleCoin> amountSimpleCoins = amountEntities.map((e) => SimpleCoin(amount: e.amount, denom: e.denom)).toList();

      List<SimpleCoin> feeSimpleCoins = entity.fee.map((e) => SimpleCoin(amount: e.amount, denom: e.denom)).toList();
      List<Coin> fees = feeSimpleCoins.map((e) => tokensService.buildCoinWithAlias(e, tokenAliases[e.denom])).toList();
      List<Coin> amounts = amountSimpleCoins.map((e) => tokensService.buildCoinWithAlias(e, tokenAliases[e.denom])).toList();

      return Transaction(
        time: CustomDateUtils.buildDateFromSecondsSinceEpoch(entity.time),
        hash: entity.hash,
        status: entity.status,
        direction: entity.direction,
        fee: fees,
        amounts: amounts,
        from: txMsg?.from,
        to: txMsg?.to,
        method: txMsg.runtimeType.toString(),
      );
    }));

    return PaginatedListWrapper<Transaction>(items: transactions, total: response.total);
  }

  Future<PaginatedListWrapper<BlockTransaction>> getBlockTransactionsPage(String blockId, PaginatedRequest paginatedRequest) async {
    PaginatedResponseWrapper<BlockTransactionEntity> response = await transactionsRepository.getBlockTransactions(blockId, paginatedRequest);

    List<BlockTransaction> transactions = await Future.wait<BlockTransaction>(response.items.map((BlockTransactionEntity entity) async {
      TypedMsg? typedMsg = entity.msgs.firstOrNull;

      List<CoinEntity> amounts = <CoinEntity>[...(typedMsg?.data.txAmounts ?? <CoinEntity>[])];
      List<SimpleCoin> coins = amounts.map((e) => SimpleCoin(amount: e.amount, denom: e.denom)).toList();

      return BlockTransaction(
        block: entity.blockHeight,
        time: CustomDateUtils.buildDateFromSecondsSinceEpoch(entity.blockTimestamp),
        hash: entity.hash,
        fee: await tokensService.buildCoins(entity.fees.map((e) => SimpleCoin(amount: e.amount, denom: e.denom)).toList()),
        amounts: await tokensService.buildCoins(coins),
        from: typedMsg?.data.from,
        to: typedMsg?.data.to,
        method: entity.runtimeType.toString(),
      );
    }));

    return PaginatedListWrapper<BlockTransaction>(items: transactions, total: response.total);
  }

  Future<TransactionResult> getTransactionResult(String hash) async {
    TransactionResultEntity transactionResultEntity = await transactionsRepository.getTransactionResult(hash);
    List<Coin> fees = await tokensService.buildCoins(transactionResultEntity.fees.map((e) => SimpleCoin(amount: e.amount, denom: e.denom)).toList());

    return TransactionResult(
      hash: transactionResultEntity.hash,
      status: TxStatusType.fromString(transactionResultEntity.status),
      blockHeight: transactionResultEntity.blockHeight,
      blockTimestamp: CustomDateUtils.buildDateFromSecondsSinceEpoch(transactionResultEntity.blockTimestamp),
      confirmation: transactionResultEntity.confirmation,
      msgs: transactionResultEntity.msgs.map((e) => e.data).toList(),
      transactions: transactionResultEntity.transactions,
      fees: fees,
      memo: transactionResultEntity.memo,
    );
  }
}
