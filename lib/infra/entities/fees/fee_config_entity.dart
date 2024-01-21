import 'package:equatable/equatable.dart';

class FeeConfigEntity extends Equatable {
  final String defaultParameters;
  final String executionFee;
  final String failureFee;
  final String timeout;
  final String transactionType;

  FeeConfigEntity.fromJson(Map<String, dynamic> json)
      : defaultParameters = json['defaultParameters'] as String,
        executionFee = json['executionFee'] as String,
        failureFee = json['failureFee'] as String,
        timeout = json['timeout'] as String,
        transactionType = json['transactionType'] as String;

  @override
  List<Object?> get props => [defaultParameters, executionFee, failureFee, timeout, transactionType];
}
