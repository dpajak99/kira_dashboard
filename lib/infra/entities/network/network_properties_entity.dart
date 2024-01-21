import 'package:equatable/equatable.dart';

class NetworkPropertiesEntity extends Equatable {
  final String minTxFee;
  final String maxTxFee;
  final String voteQuorum;
  final String minimumProposalEndTime;
  final String proposalEnactmentTime;
  final String minProposalEndBlocks;
  final String minProposalEnactmentBlocks;
  final bool enableForeignFeePayments;
  final String mischanceRankDecreaseAmount;
  final String maxMischance;
  final String mischanceConfidence;
  final String inactiveRankDecreasePercent;
  final String minValidators;
  final String poorNetworkMaxBankSend;
  final String unjailMaxTime;
  final bool enableTokenWhitelist;
  final bool enableTokenBlacklist;
  final String minIdentityApprovalTip;
  final String uniqueIdentityKeys;
  final String ubiHardcap;
  final String validatorsFeeShare;
  final String inflationRate;
  final String inflationPeriod;
  final String unstakingPeriod;
  final String maxDelegators;
  final String minDelegationPushout;
  final String slashingPeriod;
  final String maxJailedPercentage;
  final String maxSlashingPercentage;
  final String minCustodyReward;
  final String maxCustodyBufferSize;
  final String maxCustodyTxSize;
  final String abstentionRankDecreaseAmount;
  final String maxAbstention;
  final String minCollectiveBond;
  final String minCollectiveBondingTime;
  final String maxCollectiveOutputs;
  final String minCollectiveClaimPeriod;
  final String validatorRecoveryBond;
  final String maxAnnualInflation;
  final String maxProposalTitleSize;
  final String maxProposalDescriptionSize;
  final String maxProposalPollOptionSize;
  final String maxProposalPollOptionCount;
  final String maxProposalReferenceSize;
  final String maxProposalChecksumSize;
  final String minDappBond;
  final String maxDappBond;
  final String dappBondDuration;
  final String dappVerifierBond;
  final String dappAutoDenounceTime;

  NetworkPropertiesEntity.fromJson(Map<String, dynamic> json)
      : minTxFee = json['min_tx_fee'] as String,
        maxTxFee = json['max_tx_fee'] as String,
        voteQuorum = json['vote_quorum'] as String,
        minimumProposalEndTime = json['minimum_proposal_end_time'] as String,
        proposalEnactmentTime = json['proposal_enactment_time'] as String,
        minProposalEndBlocks = json['min_proposal_end_blocks'] as String,
        minProposalEnactmentBlocks = json['min_proposal_enactment_blocks'] as String,
        enableForeignFeePayments = json['enable_foreign_fee_payments'] as bool,
        mischanceRankDecreaseAmount = json['mischance_rank_decrease_amount'] as String,
        maxMischance = json['max_mischance'] as String,
        mischanceConfidence = json['mischance_confidence'] as String,
        inactiveRankDecreasePercent = json['inactive_rank_decrease_percent'] as String,
        minValidators = json['min_validators'] as String,
        poorNetworkMaxBankSend = json['poor_network_max_bank_send'] as String,
        unjailMaxTime = json['unjail_max_time'] as String,
        enableTokenWhitelist = json['enable_token_whitelist'] as bool,
        enableTokenBlacklist = json['enable_token_blacklist'] as bool,
        minIdentityApprovalTip = json['min_identity_approval_tip'] as String,
        uniqueIdentityKeys = json['unique_identity_keys'] as String,
        ubiHardcap = json['ubi_hardcap'] as String,
        validatorsFeeShare = json['validators_fee_share'] as String,
        inflationRate = json['inflation_rate'] as String,
        inflationPeriod = json['inflation_period'] as String,
        unstakingPeriod = json['unstaking_period'] as String,
        maxDelegators = json['max_delegators'] as String,
        minDelegationPushout = json['min_delegation_pushout'] as String,
        slashingPeriod = json['slashing_period'] as String,
        maxJailedPercentage = json['max_jailed_percentage'] as String,
        maxSlashingPercentage = json['max_slashing_percentage'] as String,
        minCustodyReward = json['min_custody_reward'] as String,
        maxCustodyBufferSize = json['max_custody_buffer_size'] as String,
        maxCustodyTxSize = json['max_custody_tx_size'] as String,
        abstentionRankDecreaseAmount = json['abstention_rank_decrease_amount'] as String,
        maxAbstention = json['max_abstention'] as String,
        minCollectiveBond = json['min_collective_bond'] as String,
        minCollectiveBondingTime = json['min_collective_bonding_time'] as String,
        maxCollectiveOutputs = json['max_collective_outputs'] as String,
        minCollectiveClaimPeriod = json['min_collective_claim_period'] as String,
        validatorRecoveryBond = json['validator_recovery_bond'] as String,
        maxAnnualInflation = json['max_annual_inflation'] as String,
        maxProposalTitleSize = json['max_proposal_title_size'] as String,
        maxProposalDescriptionSize = json['max_proposal_description_size'] as String,
        maxProposalPollOptionSize = json['max_proposal_poll_option_size'] as String,
        maxProposalPollOptionCount = json['max_proposal_poll_option_count'] as String,
        maxProposalReferenceSize = json['max_proposal_reference_size'] as String,
        maxProposalChecksumSize = json['max_proposal_checksum_size'] as String,
        minDappBond = json['min_dapp_bond'] as String,
        maxDappBond = json['max_dapp_bond'] as String,
        dappBondDuration = json['dapp_bond_duration'] as String,
        dappVerifierBond = json['dapp_verifier_bond'] as String,
        dappAutoDenounceTime = json['dapp_auto_denounce_time'] as String;

  @override
  List<Object?> get props => [
    minTxFee,
    maxTxFee,
    voteQuorum,
    minimumProposalEndTime,
    proposalEnactmentTime,
    minProposalEndBlocks,
    minProposalEnactmentBlocks,
    enableForeignFeePayments,
    mischanceRankDecreaseAmount,
    maxMischance,
    mischanceConfidence,
    inactiveRankDecreasePercent,
    minValidators,
    poorNetworkMaxBankSend,
    unjailMaxTime,
    enableTokenWhitelist,
    enableTokenBlacklist,
    minIdentityApprovalTip,
    uniqueIdentityKeys,
    ubiHardcap,
    validatorsFeeShare,
    inflationRate,
    inflationPeriod,
    unstakingPeriod,
    maxDelegators,
    minDelegationPushout,
    slashingPeriod,
    maxJailedPercentage,
    maxSlashingPercentage,
    minCustodyReward,
    maxCustodyBufferSize,
    maxCustodyTxSize,
    abstentionRankDecreaseAmount,
    maxAbstention,
    minCollectiveBond,
    minCollectiveBondingTime,
    maxCollectiveOutputs,
    minCollectiveClaimPeriod,
    validatorRecoveryBond,
    maxAnnualInflation,
    maxProposalTitleSize,
    maxProposalDescriptionSize,
    maxProposalPollOptionSize,
    maxProposalPollOptionCount,
    maxProposalReferenceSize,
    maxProposalChecksumSize,
    minDappBond,
    maxDappBond,
    dappBondDuration,
    dappVerifierBond,
    dappAutoDenounceTime,
  ];
}