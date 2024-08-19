import 'dart:typed_data';
import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/config/wallet_provider.dart';
import 'package:kira_dashboard/infra/entities/amino_sign_response.dart';
import 'package:kira_dashboard/infra/entities/balances/coin_entity.dart';
import 'package:kira_dashboard/infra/entities/transactions/in/types.dart';
import 'package:kira_dashboard/infra/entities/transactions/methods/cosmos.dart';
import 'package:kira_dashboard/infra/entities/transactions/methods/governance.dart';
import 'package:kira_dashboard/infra/entities/transactions/methods/multistaking.dart';
import 'package:kira_dashboard/infra/entities/transactions/out/broadcast_req.dart';
import 'package:kira_dashboard/infra/services/transactions_service.dart';
import 'package:kira_dashboard/models/coin.dart';
import 'package:kira_dashboard/models/transaction_remote_data.dart';
import 'package:kira_dashboard/pages/dialogs/confirm_transaction_drawer/confirm_transaction_drawer.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_route.dart';
import 'package:kira_dashboard/pages/dialogs/sign_transaction_dialog/sign_transaction_dialog.dart';
import 'package:kira_dashboard/pages/dialogs/transaction_result_dialog/transaction_result_dialog.dart';
import 'package:kira_dashboard/utils/exceptions/internal_broadcast_exception.dart';
import 'package:kira_dashboard/utils/keplr.dart';

abstract class TxProcessNotificator {
  void notifyConfirmTransaction();

  void notifyTransactionFailed([InternalBroadcastException? internalBroadcastException]);

  void notifyBroadcastTransaction();

  void notifyTransactionSucceeded(String transactionHash);
}

class DialogTxProcessNotificator implements TxProcessNotificator {
  @override
  void notifyConfirmTransaction() {
    DialogRouter().navigate(const ConfirmTransactionDialog());
  }

  @override
  void notifyBroadcastTransaction() {
    DialogRouter().replaceAll(const TransactionResultDialog(status: TransactionProcessStatus.broadcast));
  }

  @override
  void notifyTransactionFailed([InternalBroadcastException? internalBroadcastException]) {
    DialogRouter().replaceAll(TransactionResultDialog(
      status: TransactionProcessStatus.failed,
      internalBroadcastException: internalBroadcastException,
    ));
  }

  @override
  void notifyTransactionSucceeded(String transactionHash) {
    DialogRouter().replaceAll(TransactionResultDialog(
      status: TransactionProcessStatus.success,
      hash: transactionHash,
    ));
  }
}

abstract class TxSigner {
  Future<AminoSignResponse?> sign(CosmosSignDoc cosmosSignDoc);
}

class UnsafeWalletSigner extends TxSigner {
  UnsafeWalletSigner();

  @override
  Future<AminoSignResponse?> sign(CosmosSignDoc cosmosSignDoc) async {
    return _getSignature(cosmosSignDoc);
  }

  Future<AminoSignResponse?> _getSignature(CosmosSignDoc cosmosSignDoc) async {
    CosmosSignature? cosmosSignature = await DialogRouter.seperated().navigate<CosmosSignature?>(SignTransactionDialog(cosmosSignDoc: cosmosSignDoc));
    if(cosmosSignature == null) {
      return null;
    }

    AminoSignResponse aminoSignResponse = AminoSignResponse(
      signed: cosmosSignDoc,
      signature: cosmosSignature,
    );
    return aminoSignResponse;
  }
}

class KeplrWalletSigner extends TxSigner {
  KeplrWalletSigner();

  @override
  Future<AminoSignResponse?> sign(CosmosSignDoc cosmosSignDoc) async {
    return _getSignature(cosmosSignDoc);
  }

  Future<AminoSignResponse?> _getSignature(CosmosSignDoc cosmosSignDoc) async {
    KeplrImpl keplr = KeplrImpl();
    AminoSignResponse? aminoSignResponse = await keplr.signDirect(cosmosSignDoc);
    return aminoSignResponse;
  }
}

class UserTransactions {
  final TransactionsService transactionsService = TransactionsService();

  final TxProcessNotificator txProcessNotificator;
  final String signerAddress;
  final List<int> compressedPublicKey;
  final TxSigner txSigner;

  UserTransactions({
    required this.txProcessNotificator,
    required this.signerAddress,
    required this.compressedPublicKey,
    required this.txSigner,
  });

  Future<void> sendTokens({
    required String fromAddress,
    required String toAddress,
    required List<Coin> amounts,
    required Coin fee,
    String? memo,
  }) async {
    MsgSend msgSend = MsgSend(
      fromAddress: fromAddress,
      toAddress: toAddress,
      amounts: amounts.map((Coin e) => CoinEntity(amount: e.amount.toString(), denom: e.denom)).toList(),
    );
    sendTransaction(
      msg: msgSend,
      txFeeName: MsgSend.interxName,
      fee: fee,
      memo: memo,
    );
  }

  Future<void> delegateTokens({
    required String delegatorAddress,
    required String validatorAddress,
    required List<Coin> amounts,
    Coin? fee,
    String? memo,
  }) async {
    MsgDelegate msgDelegate = MsgDelegate(
      delegatorAddress: delegatorAddress,
      validatorAddress: validatorAddress,
      amounts: amounts.map((Coin e) => CoinEntity(amount: e.amount.toString(), denom: e.denom)).toList(),
    );
    sendTransaction(
      msg: msgDelegate,
      txFeeName: MsgDelegate.interxName,
      fee: fee,
      memo: memo,
    );
  }

  Future<void> undelegateTokens({
    required String delegatorAddress,
    required String validatorAddress,
    required List<Coin> amounts,
    Coin? fee,
    String? memo,
  }) async {
    MsgUndelegate msgUndelegate = MsgUndelegate(
      delegatorAddress: delegatorAddress,
      validatorAddress: validatorAddress,
      amounts: amounts.map((Coin e) => CoinEntity(amount: e.amount.toString(), denom: e.denom)).toList(),
    );
    sendTransaction(
      msg: msgUndelegate,
      txFeeName: MsgUndelegate.interxName,
      fee: fee,
      memo: memo,
    );
  }

  Future<void> claimUndelegation({
    required String senderAddress,
    required String undelegationId,
    Coin? fee,
    String? memo,
  }) async {
    MsgClaimUndelegation msgClaimUndelegation = MsgClaimUndelegation(
      sender: senderAddress,
      undelegationId: undelegationId,
    );
    sendTransaction(
      msg: msgClaimUndelegation,
      txFeeName: MsgClaimUndelegation.interxName,
      fee: fee,
      memo: memo,
    );
  }

  Future<void> claimRewards({
    required String senderAddress,
    Coin? fee,
    String? memo,
  }) async {
    MsgClaimRewards msgClaimRewards = MsgClaimRewards(
      sender: senderAddress,
    );
    sendTransaction(
      msg: msgClaimRewards,
      txFeeName: MsgClaimRewards.interxName,
      fee: fee,
      memo: memo,
    );
  }

  Future<void> registerIdentityRecords({
    required String senderAddress,
    required List<IdentityInfoEntry> identityInfoEntries,
    Coin? fee,
    String? memo,
  }) async {
    MsgRegisterIdentityRecords msgRegisterIdentityRecords = MsgRegisterIdentityRecords(
      address: senderAddress,
      infos: identityInfoEntries,
    );
    sendTransaction(
      msg: msgRegisterIdentityRecords,
      txFeeName: MsgRegisterIdentityRecords.interxName,
      fee: fee,
      memo: memo,
    );
  }

  Future<void> deleteIdentityRecords({
    required String senderAddress,
    required List<String> keys,
    Coin? fee,
    String? memo,
  }) async {
    MsgDeleteIdentityRecords msgDeleteIdentityRecords = MsgDeleteIdentityRecords(
      address: senderAddress,
      keys: keys,
    );
    sendTransaction(
      msg: msgDeleteIdentityRecords,
      txFeeName: MsgDeleteIdentityRecords.interxName,
      fee: fee,
      memo: memo,
    );
  }

  Future<void> requestRecordsVerification({
    required String senderAddress,
    required String verifierAddress,
    required List<String> recordIds,
    required Coin tip,
    Coin? fee,
    String? memo,
  }) async {
    MsgRequestIdentityRecordsVerify msgRequestIdentityRecordsVerify = MsgRequestIdentityRecordsVerify(
      address: senderAddress,
      verifier: verifierAddress,
      recordIds: recordIds,
      tip: CoinEntity(amount: tip.amount.toString(), denom: tip.denom),
    );
    sendTransaction(
      msg: msgRequestIdentityRecordsVerify,
      txFeeName: MsgRequestIdentityRecordsVerify.interxName,
      fee: fee,
      memo: memo,
    );
  }

  Future<void> cancelRecordsVerificationRequest({
    required String senderAddress,
    required int verifyRequestId,
    Coin? fee,
    String? memo,
  }) async {
    MsgCancelIdentityRecordsVerifyRequest msgCancelIdentityRecordsVerifyRequest = MsgCancelIdentityRecordsVerifyRequest(
      executor: senderAddress,
      verifyRequestId: verifyRequestId,
    );
    sendTransaction(
      msg: msgCancelIdentityRecordsVerifyRequest,
      txFeeName: MsgCancelIdentityRecordsVerifyRequest.interxName,
      fee: fee,
      memo: memo,
    );
  }

  Future<void> verifyRecords({
    required String senderAddress,
    required int verifyRequestId,
    required bool approved,
    Coin? fee,
    String? memo,
  }) async {
    MsgHandleIdentityRecordsVerifyRequest msgHandleIdentityRecordsVerifyRequest = MsgHandleIdentityRecordsVerifyRequest(
      verifier: senderAddress,
      verifyRequestId: verifyRequestId,
      yes: approved,
    );
    sendTransaction(
      msg: msgHandleIdentityRecordsVerifyRequest,
      txFeeName: MsgHandleIdentityRecordsVerifyRequest.interxName,
      fee: fee,
      memo: memo,
    );
  }

  Future<void> sendTransaction({
    required TxMsg msg,
    required String txFeeName,
    Coin? fee,
    String? memo,
  }) async {

    txProcessNotificator.notifyConfirmTransaction();
    TransactionRemoteData transactionRemoteData = await transactionsService.getRemoteUserTransactionData(signerAddress);
    Coin finalFee = fee ?? await transactionsService.getExecutionFeeForMessage(msg.messageType);

    CosmosSignDoc cosmosSignDoc = prepareMessage(
      compressedPublicKey: getIt<WalletProvider>().value!.publicKey,
      transactionRemoteData: transactionRemoteData,
      msg: msg,
      fee: finalFee,
      memo: memo,
    );

    AminoSignResponse? aminoSignResponse = await txSigner.sign(cosmosSignDoc);
    if (aminoSignResponse == null) {
      txProcessNotificator.notifyTransactionFailed();
      return;
    }

    txProcessNotificator.notifyBroadcastTransaction();

    BroadcastReq broadcastReq = BroadcastReq(
      tx: CosmosTx.signed(
        body: cosmosSignDoc.txBody,
        authInfo: cosmosSignDoc.authInfo,
        signatures: [aminoSignResponse.signature],
      ),
      mode: 'block',
    );

    String transactionHash;
    try {
      transactionHash = await transactionsService.broadcastTx(broadcastReq);
    } on InternalBroadcastException catch (e) {
      txProcessNotificator.notifyTransactionFailed(e);
      return;
    } catch (_) {
      txProcessNotificator.notifyTransactionFailed();
      return;
    }
    txProcessNotificator.notifyTransactionSucceeded(transactionHash);
  }

  CosmosSignDoc prepareMessage({
    required Uint8List compressedPublicKey,
    required TransactionRemoteData transactionRemoteData,
    required TxMsg msg,
    required Coin fee,
    String? memo,
  }) {
    CosmosSignDoc cosmosSignDoc = CosmosSignDoc(
      txBody: CosmosTxBody(messages: [], memo: memo ?? ''),
      authInfo: CosmosAuthInfo(
        signerInfos: [CosmosSignerInfo(
          publicKey: CosmosSimplePublicKey(compressedPublicKey),
          sequence: transactionRemoteData.sequence,
          modeInfo: CosmosModeInfo.single(CosmosSignMode.signModeDirect),
        )],
        fee: CosmosFee(gasLimit: BigInt.from(20000), amount: [CosmosCoin(denom: fee.denom, amount: fee.amount.toBigInt())]),
      ),
      accountNumber: transactionRemoteData.accountNumber,
      chainId: transactionRemoteData.chainId,
    );

    return cosmosSignDoc;
  }
}
