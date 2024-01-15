import 'package:equatable/equatable.dart';

class TokenRateEntity extends Equatable {
  final String denom;
  final bool feePayments;
  final String feeRate;
  final String stakeCap;
  final String stakeMin;
  final bool stakeToken;

  const TokenRateEntity({
    required this.denom,
    required this.feePayments,
    required this.feeRate,
    required this.stakeCap,
    required this.stakeMin,
    required this.stakeToken,
  });

  factory TokenRateEntity.fromJson(Map<String, dynamic> json) {
    return TokenRateEntity(
      denom: json['denom'] as String,
      feePayments: json['fee_payments'] as bool,
      feeRate: json['fee_rate'] as String,
      stakeCap: json['stake_cap'] as String,
      stakeMin: json['stake_min'] as String,
      stakeToken: json['stake_token'] as bool,
    );
  }

  @override
  List<Object?> get props => [denom, feePayments, feeRate, stakeCap, stakeMin, stakeToken];
}
