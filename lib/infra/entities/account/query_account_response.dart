import 'package:equatable/equatable.dart';
import 'package:kira_dashboard/infra/entities/account/account_entity.dart';

class QueryAccountResponse extends Equatable {
  final AccountEntity account;

  QueryAccountResponse.fromJson(Map<String, dynamic> json)
    : account = AccountEntity.fromJson(json['account']);

  @override
  List<Object?> get props => [account];
}