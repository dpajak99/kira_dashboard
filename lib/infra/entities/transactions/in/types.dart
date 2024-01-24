import 'package:kira_dashboard/infra/entities/balances/coin_entity.dart';
import 'package:kira_dashboard/infra/entities/transactions/methods/basket.dart';
import 'package:kira_dashboard/infra/entities/transactions/methods/collectives.dart';
import 'package:kira_dashboard/infra/entities/transactions/methods/cosmos.dart' as cosmos;
import 'package:kira_dashboard/infra/entities/transactions/methods/custody.dart';
import 'package:kira_dashboard/infra/entities/transactions/methods/evidence.dart';
import 'package:kira_dashboard/infra/entities/transactions/methods/governance.dart';
import 'package:kira_dashboard/infra/entities/transactions/methods/layer2.dart';
import 'package:kira_dashboard/infra/entities/transactions/methods/multistaking.dart';
import 'package:kira_dashboard/infra/entities/transactions/methods/recovery.dart';
import 'package:kira_dashboard/infra/entities/transactions/methods/slashing.dart';
import 'package:kira_dashboard/infra/entities/transactions/methods/spending.dart';
import 'package:kira_dashboard/infra/entities/transactions/methods/staking.dart';
import 'package:kira_dashboard/infra/entities/transactions/methods/tokens.dart';

abstract class TxMsg {
  String? get from;
  String? get to;
  List<CoinEntity> get txAmounts;

  String get messageType;

  String get signatureMessageType;

  Map<String, dynamic> toJson();

  Map<String, dynamic> toJsonWithType() {
    return <String, dynamic>{
      '@type': messageType,
      ...toJson(),
    };
  }

  Map<String, dynamic> toSignatureJson() {
    return <String, dynamic>{
      'type': signatureMessageType,
      'value': toJson(),
    };
  }

  static TxMsg fromJsonByName(String name, Map<String, dynamic> json) {
    return switch (name) {
      'disable-basket-deposits' => MsgDisableBasketDeposits.fromJson(json),
      'disable-basket-withdraws' => MsgDisableBasketWithdraws.fromJson(json),
      'disable-basket-swaps' => MsgDisableBasketSwaps.fromJson(json),
      'basket-token-mint' => MsgBasketTokenMint.fromJson(json),
      'basket-token-burn' => MsgBasketTokenBurn.fromJson(json),
      'basket-token-swap' => MsgBasketTokenSwap.fromJson(json),
      'basket-claim-rewards' => MsgBasketClaimRewards.fromJson(json),
      //
      'create-collective' => MsgCreateCollective.fromJson(json),
      'bond-collective' => MsgBondCollective.fromJson(json),
      'donate-collective' => MsgDonateCollective.fromJson(json),
      'withdraw-collective' => MsgWithdrawCollective.fromJson(json),
      //
      'send' => cosmos.MsgSend.fromJson(json),
      //
      'create-custody' => MsgCreateCustodyRecord.fromJson(json),
      'disable-custody' => MsgDisableCustodyRecord.fromJson(json),
      'drop-custody' => MsgDropCustodyRecord.fromJson(json),
      'add-to-custody-whitelist' => MsgAddToCustodyWhiteList.fromJson(json),
      'add-to-custody-custodians' => MsgAddToCustodyCustodians.fromJson(json),
      'remove-from-custody-custodians' => MsgRemoveFromCustodyCustodians.fromJson(json),
      'drop-custody-custodians' => MsgDropCustodyCustodians.fromJson(json),
      'remove-from-custody-whitelist' => MsgRemoveFromCustodyWhiteList.fromJson(json),
      'drop-custody-whitelist' => MsgDropCustodyWhiteList.fromJson(json),
      'approve-custody-transaction' => MsgApproveCustodyTransaction.fromJson(json),
      'decline-custody-transaction' => MsgDeclineCustodyTransaction.fromJson(json),
      'password-confirm-transaction' => MsgPasswordConfirmTransaction.fromJson(json),
      'custody-send' => MsgSend.fromJson(json),
      //
      'submit_evidence' => MsgSubmitEvidence.fromJson(json),
      //
      'submit-proposal' => MsgSubmitProposal.fromJson(json),
      'vote-proposal' => MsgVoteProposal.fromJson(json),
      'whitelist-permissions' => MsgWhitelistPermissions.fromJson(json),
      'blacklist-permissions' => MsgBlacklistPermissions.fromJson(json),
      'claim-councilor' => MsgClaimCouncilor.fromJson(json),
      'set-network-properties' => MsgSetNetworkProperties.fromJson(json),
      'set-execution-fee' => MsgSetExecutionFee.fromJson(json),
      'create-role' => MsgCreateRole.fromJson(json),
      'assign-role' => MsgAssignRole.fromJson(json),
      'unassign-role' => MsgUnassignRole.fromJson(json),
      'whitelist-role-permission' => MsgWhitelistRolePermission.fromJson(json),
      'blacklist-role-permission' => MsgBlacklistRolePermission.fromJson(json),
      'remove-whitelist-role-permission' => MsgRemoveWhitelistRolePermission.fromJson(json),
      'remove-blacklist-role-permission' => MsgRemoveBlacklistRolePermission.fromJson(json),
      'register-identity-records' => MsgRegisterIdentityRecords.fromJson(json),
      'edit-identity-record' => MsgDeleteIdentityRecords.fromJson(json),
      'request-identity-records-verify' => MsgRequestIdentityRecordsVerify.fromJson(json),
      'handle-identity-records-verify-request' => MsgHandleIdentityRecordsVerifyRequest.fromJson(json),
      'cancel-identity-records-verify-request' => MsgCancelIdentityRecordsVerifyRequest.fromJson(json),
      //
      'create-dapp-proposal' => MsgCreateDappProposal.fromJson(json),
      'bond-dapp-proposal' => MsgBondDappProposal.fromJson(json),
      'reclaim-dapp-bond-proposal' => MsgReclaimDappBondProposal.fromJson(json),
      'join-dapp-verifier-with-bond' => MsgJoinDappVerifierWithBond.fromJson(json),
      'exit-dapp' => MsgExitDapp.fromJson(json),
      'redeem-dapp-pool-tx' => MsgRedeemDappPoolTx.fromJson(json),
      'swap-dapp-pool-tx' => MsgSwapDappPoolTx.fromJson(json),
      'convert-dapp-pool-tx' => MsgConvertDappPoolTx.fromJson(json),
      'pause-dapp-tx' => MsgPauseDappTx.fromJson(json),
      'unpause-dapp-tx' => MsgUnPauseDappTx.fromJson(json),
      'reactivate-dapp-tx' => MsgReactivateDappTx.fromJson(json),
      'execute-dapp-tx' => MsgExecuteDappTx.fromJson(json),
      'denounce-leader-tx' => MsgDenounceLeaderTx.fromJson(json),
      'transition-dapp-tx' => MsgTransitionDappTx.fromJson(json),
      'approve-dapp-transition-tx' => MsgApproveDappTransitionTx.fromJson(json),
      'reject-dapp-transition-tx' => MsgRejectDappTransitionTx.fromJson(json),
      'transfer-dapp-tx' => MsgTransferDappTx.fromJson(json),
      'ack-transfer-dapp-tx' => MsgAckTransferDappTx.fromJson(json),
      'mint-create-ft-tx' => MsgMintCreateFtTx.fromJson(json),
      'mint-create-nft-tx' => MsgMintCreateNftTx.fromJson(json),
      'mint-issue-tx' => MsgMintIssueTx.fromJson(json),
      'mint-burn-tx' => MsgMintBurnTx.fromJson(json),
      //
      'upsert_staking_pool' => MsgUpsertStakingPool.fromJson(json),
      'delegate' => MsgDelegate.fromJson(json),
      'undelegate' => MsgUndelegate.fromJson(json),
      'claim_rewards' => MsgClaimRewards.fromJson(json),
      'claim_undelegation' => MsgClaimUndelegation.fromJson(json),
      'claim_matured_undelegations' => MsgClaimMaturedUndelegations.fromJson(json),
      'set_compound_info' => MsgSetCompoundInfo.fromJson(json),
      'register_delegator' => MsgRegisterDelegator.fromJson(json),
      //
      'register-recovery-secret' => MsgRegisterRecoverySecret.fromJson(json),
      'rotate-recovery-address' => MsgRotateRecoveryAddress.fromJson(json),
      'issue-recovery-tokens' => MsgIssueRecoveryTokens.fromJson(json),
      'burn-recovery-tokens' => MsgBurnRecoveryTokens.fromJson(json),
      'register-rrtoken-holder' => MsgRegisterRRTokenHolder.fromJson(json),
      'claim-rrholder-rewards' => MsgClaimRRHolderRewards.fromJson(json),
      'rotate-validator-by-half-rr-token-holder' => MsgRotateValidatorByHalfRRTokenHolder.fromJson(json),
      //
      'activate' => MsgActivate.fromJson(json),
      'pause' => MsgPause.fromJson(json),
      'unpause' => MsgUnpause.fromJson(json),
      //
      'create-spending-pool' => MsgCreateSpendingPool.fromJson(json),
      'deposit-spending-pool' => MsgDepositSpendingPool.fromJson(json),
      'register-spending-pool-beneficiary' => MsgRegisterSpendingPoolBeneficiary.fromJson(json),
      'claim-spending-pool' => MsgClaimSpendingPool.fromJson(json),
      //
      'claim-validator' => MsgClaimValidator.fromJson(json),
      //
      'upsert-token-alias' => MsgUpsertTokenAlias.fromJson(json),
      'upsert-token-rate' => MsgUpsertTokenRate.fromJson(json),
      //
      (_) => throw Exception('Unknown TxMsg name: $name'),
    };
  }
}
