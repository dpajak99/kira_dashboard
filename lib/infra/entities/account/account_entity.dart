import 'package:equatable/equatable.dart';

class PubKey extends Equatable {
  final String type;
  final String value;

  PubKey.fromJson(Map<String, dynamic> json)
    : type = json['@type'],
      value = json['value'];

  @override
  List<Object?> get props => [type, value];
}

class AccountEntity extends Equatable {
  final String type;
  final String accountNumber;
  final String address;
  final PubKey pubKey;
  final String sequence;

  AccountEntity.fromJson(Map<String, dynamic> json)
    : type = json['@type'],
      accountNumber = json['account_number'],
      address = json['address'],
      pubKey = PubKey.fromJson(json['pub_key']),
      sequence = json['sequence'];

  @override
  List<Object?> get props => [type, accountNumber, address, pubKey, sequence];
}