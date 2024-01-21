import 'package:kira_dashboard/infra/entities/balances/coin_entity.dart';
import 'package:kira_dashboard/infra/entities/transactions/methods/cosmos.dart';
import 'package:kira_dashboard/infra/entities/transactions/methods/governance.dart';
import 'package:kira_dashboard/infra/entities/transactions/methods/multistaking.dart';
import 'package:kira_dashboard/models/coin.dart';

class UserTransactions {
  Future<void> sendTokens({
    required String fromAddress,
    required String toAddress,
    required List<Coin> amounts,
  }) async {
    MsgSend msgSend = MsgSend(
      fromAddress: fromAddress,
      toAddress: toAddress,
      amounts: amounts.map((Coin e) => CoinEntity(amount: e.amount, denom: e.denom)).toList(),
    );
  }

  Future<void> delegateTokens({
    required String delegatorAddress,
    required String validatorAddress,
    required List<Coin> amounts,
  }) async {
    MsgDelegate msgDelegate = MsgDelegate(
      delegatorAddress: delegatorAddress,
      validatorAddress: validatorAddress,
      amounts: amounts.map((Coin e) => CoinEntity(amount: e.amount, denom: e.denom)).toList(),
    );
  }

  Future<void> undelegateTokens({
    required String delegatorAddress,
    required String validatorAddress,
    required List<Coin> amounts,
  }) async {
    MsgUndelegate msgUndelegate = MsgUndelegate(
      delegatorAddress: delegatorAddress,
      validatorAddress: validatorAddress,
      amounts: amounts.map((Coin e) => CoinEntity(amount: e.amount, denom: e.denom)).toList(),
    );
  }

  Future<void> claimUndelegation({
    required String senderAddress,
    required String undelegationId,
  }) async {
    MsgClaimUndelegation msgClaimUndelegation = MsgClaimUndelegation(
      sender: senderAddress,
      undelegationId: undelegationId,
    );
  }

  Future<void> claimRewards({
    required String senderAddress,
  }) async {
    MsgClaimRewards msgClaimRewards = MsgClaimRewards(
      sender: senderAddress,
    );
  }

  Future<void> registerIdentityRecords({
    required String senderAddress,
    required List<IdentityInfoEntry> identityInfoEntries,
  }) async {
    MsgRegisterIdentityRecords msgRegisterIdentityRecords = MsgRegisterIdentityRecords(
      address: senderAddress,
      infos: identityInfoEntries,
    );
  }

  Future<void> requestRecordsVerification({
    required String senderAddress,
    required String verifierAddress,
    required List<int> recordIds,
    required Coin tip,
  }) async {
    MsgRequestIdentityRecordsVerify msgRequestIdentityRecordsVerify = MsgRequestIdentityRecordsVerify(
      address: senderAddress,
      verifier: verifierAddress,
      recordIds: recordIds,
      tip: CoinEntity(amount: tip.amount, denom: tip.denom),
    );
  }

  Future<void> cancelRecordsVerificationRequest({
    required String senderAddress,
    required int verifyRequestId,
  }) async {
    MsgCancelIdentityRecordsVerifyRequest msgCancelIdentityRecordsVerifyRequest = MsgCancelIdentityRecordsVerifyRequest(
      executor: senderAddress,
      verifyRequestId: verifyRequestId,
    );
  }

  Future<void> verifyRecords({
    required String senderAddress,
    required int verifyRequestId,
    required bool approved,
  }) async {
    MsgHandleIdentityRecordsVerifyRequest msgHandleIdentityRecordsVerifyRequest = MsgHandleIdentityRecordsVerifyRequest(
      verifier: senderAddress,
      verifyRequestId: verifyRequestId,
      yes: approved,
    );
  }
}
