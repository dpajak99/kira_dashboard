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
      'disable-basket-deposits' || 'kiraHub/MsgDisableBasketDeposits' => MsgDisableBasketDeposits.fromJson(json),
      'disable-basket-withdraws' || 'kiraHub/MsgDisableBasketWithdraws' => MsgDisableBasketWithdraws.fromJson(json),
      'disable-basket-swaps' || 'kiraHub/MsgDisableBasketSwap' => MsgDisableBasketSwaps.fromJson(json),
      'basket-token-mint' || 'kiraHub/MsgBasketTokenMint' => MsgBasketTokenMint.fromJson(json),
      'basket-token-burn' || 'kiraHub/MsgBasketTokenBurn' => MsgBasketTokenBurn.fromJson(json),
      'basket-token-swap' || 'kiraHub/MsgBasketTokenSwap' => MsgBasketTokenSwap.fromJson(json),
      'basket-claim-rewards' || 'kiraHub/MsgBasketClaimRewards' => MsgBasketClaimRewards.fromJson(json),
      //
      'create-collective' || 'kiraHub/MsgCreateCollective' => MsgCreateCollective.fromJson(json),
      'bond-collective' || 'kiraHub/MsgBondCollective' => MsgBondCollective.fromJson(json),
      'donate-collective' || 'kiraHub/MsgDonateCollective' => MsgDonateCollective.fromJson(json),
      'withdraw-collective' || 'kiraHub/MsgWithdrawCollective' => MsgWithdrawCollective.fromJson(json),
      //
      'send' || 'cosmos-sdk/MsgSend' => cosmos.MsgSend.fromJson(json),
      //
      'create-custody' || 'kiraHub/MsgCreateCustodyRecord' => MsgCreateCustodyRecord.fromJson(json),
      'disable-custody' || 'kiraHub/MsgDisableCustodyRecord' => MsgDisableCustodyRecord.fromJson(json),
      'drop-custody' || 'kiraHub/MsgDropCustodyRecord' => MsgDropCustodyRecord.fromJson(json),
      'add-to-custody-whitelist' || 'kiraHub/MsgAddToCustodyWhiteList' => MsgAddToCustodyWhiteList.fromJson(json),
      'add-to-custody-custodians' || 'kiraHub/MsgAddToCustodyCustodians' => MsgAddToCustodyCustodians.fromJson(json),
      'remove-from-custody-custodians' || 'kiraHub/MsgRemoveFromCustodyCustodians' => MsgRemoveFromCustodyCustodians.fromJson(json),
      'drop-custody-custodians' || 'kiraHub/MsgDropCustodyCustodians' => MsgDropCustodyCustodians.fromJson(json),
      'remove-from-custody-whitelist' => MsgRemoveFromCustodyWhiteList.fromJson(json),
      'drop-custody-whitelist' || 'kiraHub/MsgRemoveFromCustodyWhiteList' => MsgDropCustodyWhiteList.fromJson(json),
      'approve-custody-transaction' || 'kiraHub/MsgApproveCustodyTransaction' => MsgApproveCustodyTransaction.fromJson(json),
      'decline-custody-transaction' || 'kiraHub/MsgDeclineCustodyTransaction' => MsgDeclineCustodyTransaction.fromJson(json),
      'password-confirm-transaction' || 'kiraHub/MsgPasswordConfirmTransaction' => MsgPasswordConfirmTransaction.fromJson(json),
      'custody-send' || 'kiraHub/MsgSend'=> MsgSend.fromJson(json),
      //
      'submit_evidence' || 'kiraHub/MsgSubmitEvidence' => MsgSubmitEvidence.fromJson(json),
      //
      'submit-proposal' || 'kiraHub/MsgSubmitProposal' => MsgSubmitProposal.fromJson(json),
      'vote-proposal' || 'kiraHub/MsgVoteProposal' => MsgVoteProposal.fromJson(json),
      'whitelist-permissions' || 'kiraHub/MsgWhitelistPermissions' => MsgWhitelistPermissions.fromJson(json),
      'blacklist-permissions' || 'kiraHub/MsgBlacklistPermissions' => MsgBlacklistPermissions.fromJson(json),
      'claim-councilor' || 'kiraHub/MsgClaimCouncilor' => MsgClaimCouncilor.fromJson(json),
      'set-network-properties' || 'kiraHub/MsgSetNetworkProperties' => MsgSetNetworkProperties.fromJson(json),
      'set-execution-fee' || 'kiraHub/MsgSetExecutionFee' => MsgSetExecutionFee.fromJson(json),
      'create-role' || 'kiraHub/MsgCreateRole' => MsgCreateRole.fromJson(json),
      'assign-role' || 'kiraHub/MsgAssignRole' => MsgAssignRole.fromJson(json),
      'unassign-role' || '/kira.gov.MsgUnassignRole' => MsgUnassignRole.fromJson(json),
      'whitelist-role-permission' || 'kiraHub/MsgWhitelistRolePermission' => MsgWhitelistRolePermission.fromJson(json),
      'blacklist-role-permission' || 'kiraHub/MsgBlacklistRolePermission' => MsgBlacklistRolePermission.fromJson(json),
      'remove-whitelist-role-permission' || 'kiraHub/MsgRemoveWhitelistRolePermission' => MsgRemoveWhitelistRolePermission.fromJson(json),
      'remove-blacklist-role-permission' || 'kiraHub/MsgRemoveBlacklistRolePermission' => MsgRemoveBlacklistRolePermission.fromJson(json),
      'register-identity-records' || 'kiraHub/MsgRegisterIdentityRecords' => MsgRegisterIdentityRecords.fromJson(json),
      'edit-identity-record' || 'kiraHub/MsgDeleteIdentityRecords' => MsgDeleteIdentityRecords.fromJson(json),
      'request-identity-records-verify' || 'kiraHub/MsgRequestIdentityRecordsVerify' => MsgRequestIdentityRecordsVerify.fromJson(json),
      'handle-identity-records-verify-request' || 'kiraHub/MsgHandleIdentityRecordsVerifyRequest' => MsgHandleIdentityRecordsVerifyRequest.fromJson(json),
      'cancel-identity-records-verify-request' || 'kiraHub/MsgCancelIdentityRecordsVerifyRequest' => MsgCancelIdentityRecordsVerifyRequest.fromJson(json),
      //
      'create-dapp-proposal' || 'kiraHub/MsgCreateDappProposal' => MsgCreateDappProposal.fromJson(json),
      'bond-dapp-proposal' || 'kiraHub/MsgBondDappProposal'  => MsgBondDappProposal.fromJson(json),
      'reclaim-dapp-bond-proposal' || 'kiraHub/MsgReclaimDappBondProposal' => MsgReclaimDappBondProposal.fromJson(json),
      'join-dapp-verifier-with-bond' || 'kiraHub/MsgJoinDappVerifierWithBond' => MsgJoinDappVerifierWithBond.fromJson(json),
      'exit-dapp' || 'kiraHub/MsgExitDapp' => MsgExitDapp.fromJson(json),
      'redeem-dapp-pool-tx' || 'kiraHub/MsgRedeemDappPoolTx' => MsgRedeemDappPoolTx.fromJson(json),
      'swap-dapp-pool-tx' || 'kiraHub/MsgSwapDappPoolTx' => MsgSwapDappPoolTx.fromJson(json),
      'convert-dapp-pool-tx' || 'kiraHub/MsgConvertDappPoolTx' => MsgConvertDappPoolTx.fromJson(json),
      'pause-dapp-tx' || 'kiraHub/MsgPauseDappTx' => MsgPauseDappTx.fromJson(json),
      'unpause-dapp-tx' || 'kiraHub/MsgUnPauseDappTx' => MsgUnPauseDappTx.fromJson(json),
      'reactivate-dapp-tx' || 'kiraHub/MsgReactivateDappTx' => MsgReactivateDappTx.fromJson(json),
      'execute-dapp-tx' || 'kiraHub/MsgExecuteDappTx' => MsgExecuteDappTx.fromJson(json),
      'denounce-leader-tx' || 'kiraHub/MsgDenounceLeaderTx' => MsgDenounceLeaderTx.fromJson(json),
      'transition-dapp-tx' || 'kiraHub/MsgTransitionDappTx' => MsgTransitionDappTx.fromJson(json),
      'approve-dapp-transition-tx' || 'kiraHub/MsgApproveDappTransitionTx' => MsgApproveDappTransitionTx.fromJson(json),
      'reject-dapp-transition-tx' || 'kiraHub/MsgRejectDappTransitionTx' => MsgRejectDappTransitionTx.fromJson(json),
      'transfer-dapp-tx' || 'kiraHub/MsgTransferDappTx' => MsgTransferDappTx.fromJson(json),
      'ack-transfer-dapp-tx' || 'kiraHub/MsgAckTransferDappTx' => MsgAckTransferDappTx.fromJson(json),
      'mint-create-ft-tx' || 'kiraHub/MsgMintCreateFtTx' => MsgMintCreateFtTx.fromJson(json),
      'mint-create-nft-tx' || 'kiraHub/MsgMintCreateNftTx' => MsgMintCreateNftTx.fromJson(json),
      'mint-issue-tx' || 'kiraHub/MsgMintIssueTx' => MsgMintIssueTx.fromJson(json),
      'mint-burn-tx' || 'kiraHub/MsgMintBurnTx' => MsgMintBurnTx.fromJson(json),
      //
      'upsert_staking_pool' || 'kiraHub/MsgUpsertStakingPool' => MsgUpsertStakingPool.fromJson(json),
      'delegate' || 'kiraHub/MsgDelegate' => MsgDelegate.fromJson(json),
      'undelegate' || 'kiraHub/MsgUndelegate' => MsgUndelegate.fromJson(json),
      'claim_rewards' || 'kiraHub/MsgClaimRewards' => MsgClaimRewards.fromJson(json),
      'claim_undelegation' || 'kiraHub/MsgClaimUndelegation' => MsgClaimUndelegation.fromJson(json),
      'claim_matured_undelegations' || 'kiraHub/MsgClaimMaturedUndelegations' => MsgClaimMaturedUndelegations.fromJson(json),
      'set_compound_info' || 'kiraHub/MsgSetCompoundInfo' => MsgSetCompoundInfo.fromJson(json),
      'register_delegator' || 'kiraHub/MsgRegisterDelegator' => MsgRegisterDelegator.fromJson(json),
      //
      'register-recovery-secret' || 'kiraHub/MsgRegisterRecoverySecret' => MsgRegisterRecoverySecret.fromJson(json),
      'rotate-recovery-address' || 'kiraHub/MsgRotateRecoveryAddress' => MsgRotateRecoveryAddress.fromJson(json),
      'issue-recovery-tokens' || 'kiraHub/MsgIssueRecoveryTokens' => MsgIssueRecoveryTokens.fromJson(json),
      'burn-recovery-tokens' || 'kiraHub/MsgBurnRecoveryTokens' => MsgBurnRecoveryTokens.fromJson(json),
      'register-rrtoken-holder' || 'kiraHub/MsgRegisterRRTokenHolder' => MsgRegisterRRTokenHolder.fromJson(json),
      'claim-rrholder-rewards' || 'kiraHub/MsgClaimRRHolderRewards' => MsgClaimRRHolderRewards.fromJson(json),
      'rotate-validator-by-half-rr-token-holder' || 'kiraHub/MsgRotateValidatorByHalfRRTokenHolder' => MsgRotateValidatorByHalfRRTokenHolder.fromJson(json),
      //
      'activate' || 'kiraHub/MsgActivate' => MsgActivate.fromJson(json),
      'pause' || 'kiraHub/MsgPause' => MsgPause.fromJson(json),
      'unpause' || 'kiraHub/MsgUnpause' => MsgUnpause.fromJson(json),
      //
      'create-spending-pool' || 'kiraHub/MsgCreateSpendingPool' => MsgCreateSpendingPool.fromJson(json),
      'deposit-spending-pool' || 'kiraHub/MsgDepositSpendingPool' => MsgDepositSpendingPool.fromJson(json),
      'register-spending-pool-beneficiary' ||  'kiraHub/MsgRegisterSpendingPoolBeneficiary' => MsgRegisterSpendingPoolBeneficiary.fromJson(json),
      'claim-spending-pool' || 'kiraHub/MsgClaimSpendingPool' => MsgClaimSpendingPool.fromJson(json),
      //
      'claim-validator' || 'kiraHub/MsgClaimValidator' => MsgClaimValidator.fromJson(json),
      //
      'upsert-token-alias' || 'kiraHub/MsgUpsertTokenAlias' => MsgUpsertTokenAlias.fromJson(json),
      'upsert-token-rate' || 'kiraHub/MsgUpsertTokenRate' => MsgUpsertTokenRate.fromJson(json),
      //
      (_) => throw Exception('Unknown TxMsg name: $name'),
    };
  }
}
