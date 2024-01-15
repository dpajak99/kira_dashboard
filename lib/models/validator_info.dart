import 'package:equatable/equatable.dart';

class ValidatorInfo extends Equatable {
  final String moniker;
  final String address;
  final String valkey;
  final String? website;
  final String? logo;

  const ValidatorInfo({
    required this.moniker,
    required this.address,
    required this.valkey,
    this.website,
    this.logo,
  });

  @override
  List<Object?> get props => <Object?>[moniker, address, valkey, website, logo];
}