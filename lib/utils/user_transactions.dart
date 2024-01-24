import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kira_dashboard/infra/entities/balances/coin_entity.dart';
import 'package:kira_dashboard/infra/entities/transactions/in/types.dart';
import 'package:kira_dashboard/infra/entities/transactions/methods/cosmos.dart';
import 'package:kira_dashboard/infra/entities/transactions/methods/governance.dart';
import 'package:kira_dashboard/infra/entities/transactions/methods/multistaking.dart';
import 'package:kira_dashboard/infra/entities/transactions/out/broadcast_req.dart';
import 'package:kira_dashboard/infra/entities/transactions/out/transaction/components/auth_info.dart';
import 'package:kira_dashboard/infra/entities/transactions/out/transaction/components/mode_info/mode_info.dart';
import 'package:kira_dashboard/infra/entities/transactions/out/transaction/components/mode_info/sign_mode.dart';
import 'package:kira_dashboard/infra/entities/transactions/out/transaction/components/mode_info/single_mode_info.dart';
import 'package:kira_dashboard/infra/entities/transactions/out/transaction/components/signer_info.dart';
import 'package:kira_dashboard/infra/entities/transactions/out/transaction/components/tx_body.dart';
import 'package:kira_dashboard/infra/entities/transactions/out/transaction/components/tx_fee.dart';
import 'package:kira_dashboard/infra/entities/transactions/out/transaction/components/tx_pub_key.dart';
import 'package:kira_dashboard/infra/entities/transactions/out/transaction/std_sign_doc.dart';
import 'package:kira_dashboard/infra/entities/transactions/out/transaction/tx.dart';
import 'package:kira_dashboard/infra/services/transactions_service.dart';
import 'package:kira_dashboard/models/coin.dart';
import 'package:kira_dashboard/models/transaction_remote_data.dart';
import 'package:kira_dashboard/pages/dialogs/confirm_transaction_drawer/confirm_transaction_drawer.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_route.dart';
import 'package:kira_dashboard/pages/dialogs/sign_transaction_dialog/sign_transaction_dialog.dart';
import 'package:kira_dashboard/pages/dialogs/transaction_result_dialog/transaction_result_dialog.dart';
import 'package:kira_dashboard/utils/map_utils.dart';

abstract class TxProcessNotificator {
  void notifyConfirmTransaction();

  void notifyTransactionFailed();

  void notifyBroadcastTransaction();

  void notifyTransactionSucceeded();
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
  void notifyTransactionFailed() {
    DialogRouter().replaceAll(const TransactionResultDialog(status: TransactionProcessStatus.failed));
  }

  @override
  void notifyTransactionSucceeded() {
    DialogRouter().replaceAll(const TransactionResultDialog(status: TransactionProcessStatus.success));
  }
}

abstract class TxSigner {
  Future<String?> sign(String message);
}

class UnsafeWalletSigner extends TxSigner {
  UnsafeWalletSigner();

  @override
  Future<String?> sign(String message) async {
    return _getSignature(message);
  }

  Future<String?> _getSignature(String message) async {
    String? signature = await DialogRouter.seperated().navigate<String?>(SignTransactionDialog(message: message));
    return signature;
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
    sendTransaction(msg: msgSend, fee: fee, memo: memo);
  }

  Future<void> delegateTokens({
    required String delegatorAddress,
    required String validatorAddress,
    required List<Coin> amounts,
    required Coin fee,
    String? memo,
  }) async {
    MsgDelegate msgDelegate = MsgDelegate(
      delegatorAddress: delegatorAddress,
      validatorAddress: validatorAddress,
      amounts: amounts.map((Coin e) => CoinEntity(amount: e.amount.toString(), denom: e.denom)).toList(),
    );
    sendTransaction(msg: msgDelegate, fee: fee, memo: memo);
  }

  Future<void> undelegateTokens({
    required String delegatorAddress,
    required String validatorAddress,
    required List<Coin> amounts,
    required Coin fee,
    String? memo,
  }) async {
    MsgUndelegate msgUndelegate = MsgUndelegate(
      delegatorAddress: delegatorAddress,
      validatorAddress: validatorAddress,
      amounts: amounts.map((Coin e) => CoinEntity(amount: e.amount.toString(), denom: e.denom)).toList(),
    );
    sendTransaction(msg: msgUndelegate, fee: fee, memo: memo);
  }

  Future<void> claimUndelegation({
    required String senderAddress,
    required String undelegationId,
    required Coin fee,
    String? memo,
  }) async {
    MsgClaimUndelegation msgClaimUndelegation = MsgClaimUndelegation(
      sender: senderAddress,
      undelegationId: undelegationId,
    );
    sendTransaction(msg: msgClaimUndelegation, fee: fee, memo: memo);
  }

  Future<void> claimRewards({
    required String senderAddress,
    required Coin fee,
    String? memo,
  }) async {
    MsgClaimRewards msgClaimRewards = MsgClaimRewards(
      sender: senderAddress,
    );
    sendTransaction(msg: msgClaimRewards, fee: fee, memo: memo);
  }

  Future<void> registerIdentityRecords({
    required String senderAddress,
    required List<IdentityInfoEntry> identityInfoEntries,
    required Coin fee,
    String? memo,
  }) async {
    MsgRegisterIdentityRecords msgRegisterIdentityRecords = MsgRegisterIdentityRecords(
      address: senderAddress,
      infos: identityInfoEntries,
    );
    sendTransaction(msg: msgRegisterIdentityRecords, fee: fee, memo: memo);
  }

  Future<void> deleteIdentityRecords({
    required String senderAddress,
    required List<String> keys,
    required Coin fee,
    String? memo,
  }) async {
    MsgDeleteIdentityRecords msgDeleteIdentityRecords = MsgDeleteIdentityRecords(
      address: senderAddress,
      keys: keys,
    );
    sendTransaction(msg: msgDeleteIdentityRecords, fee: fee, memo: memo);
  }

  Future<void> requestRecordsVerification({
    required String senderAddress,
    required String verifierAddress,
    required List<String> recordIds,
    required Coin tip,
    required Coin fee,
    String? memo,
  }) async {
    MsgRequestIdentityRecordsVerify msgRequestIdentityRecordsVerify = MsgRequestIdentityRecordsVerify(
      address: senderAddress,
      verifier: verifierAddress,
      recordIds: recordIds,
      tip: CoinEntity(amount: tip.amount.toString(), denom: tip.denom),
    );
    sendTransaction(msg: msgRequestIdentityRecordsVerify, fee: fee, memo: memo);
  }

  Future<void> cancelRecordsVerificationRequest({
    required String senderAddress,
    required int verifyRequestId,
    required Coin fee,
    String? memo,
  }) async {
    MsgCancelIdentityRecordsVerifyRequest msgCancelIdentityRecordsVerifyRequest = MsgCancelIdentityRecordsVerifyRequest(
      executor: senderAddress,
      verifyRequestId: verifyRequestId,
    );
    sendTransaction(msg: msgCancelIdentityRecordsVerifyRequest, fee: fee, memo: memo);
  }

  Future<void> verifyRecords({
    required String senderAddress,
    required int verifyRequestId,
    required bool approved,
    required Coin fee,
    String? memo,
  }) async {
    MsgHandleIdentityRecordsVerifyRequest msgHandleIdentityRecordsVerifyRequest = MsgHandleIdentityRecordsVerifyRequest(
      verifier: senderAddress,
      verifyRequestId: verifyRequestId,
      yes: approved,
    );
    sendTransaction(msg: msgHandleIdentityRecordsVerifyRequest, fee: fee, memo: memo);
  }

  Future<void> sendTransaction({
    required TxMsg msg,
    required Coin fee,
    String? memo,
  }) async {
    txProcessNotificator.notifyConfirmTransaction();
    TransactionRemoteData transactionRemoteData = await transactionsService.getRemoteUserTransactionData(signerAddress);

    String message = await prepareMessage(transactionRemoteData: transactionRemoteData, msg: msg, fee: fee, memo: memo);

    String? signature = await txSigner.sign(message);
    if (signature == null) {
      txProcessNotificator.notifyTransactionFailed();
      return;
    }

    txProcessNotificator.notifyBroadcastTransaction();

    SignerInfo signerInfo = SignerInfo(
      publicKey: TxPubKey(key: base64Encode(compressedPublicKey)),
      modeInfo: const ModeInfo(single: SingleModeInfo(mode: SignMode.SIGN_MODE_LEGACY_AMINO_JSON)),
      sequence: transactionRemoteData.sequence,
    );

    BroadcastReq broadcastReq = BroadcastReq(
      tx: Tx(
        body: TxBody(
          messages: <TxMsg>[msg],
          memo: memo ?? '',
        ),
        authInfo: AuthInfo(
          signerInfos: <SignerInfo>[signerInfo],
          fee: TxFee(
            amount: <CoinEntity>[
              CoinEntity(amount: fee.amount.toString(), denom: fee.denom),
            ],
          ),
        ),
        signatures: <String>[signature],
      ),
      mode: 'block',
    );

    await transactionsService.broadcastTx(broadcastReq);

    txProcessNotificator.notifyTransactionSucceeded();
  }

  Future<String> prepareMessage({
    required TransactionRemoteData transactionRemoteData,
    required TxMsg msg,
    required Coin fee,
    String? memo,
  }) async {
    StdSignDoc stdSignDoc = StdSignDoc(
      accountNumber: transactionRemoteData.accountNumber,
      sequence: transactionRemoteData.sequence,
      chainId: transactionRemoteData.chainId,
      memo: memo ?? '',
      fee: TxFee(
        amount: <CoinEntity>[
          CoinEntity(amount: fee.amount.toString(), denom: fee.denom),
        ],
      ),
      messages: [msg],
    );

    Map<String, dynamic> signatureDataJson = MapUtils.sort(stdSignDoc.toSignatureJson());
    String signatureDataString = json.encode(signatureDataJson);

    return signatureDataString;
  }
}
