import 'package:equatable/equatable.dart';

class ValidatorInfoEntity extends Equatable {
  final String moniker;
  final String address;
  final String valkey;
  final String? website;
  final String? logo;

  const ValidatorInfoEntity({
    required this.moniker,
    required this.address,
    required this.valkey,
    this.website,
    this.logo,
  });

  factory ValidatorInfoEntity.fromJson(Map<String, dynamic> json) {
    return ValidatorInfoEntity(
      moniker: json['moniker'] as String,
      address: json['address'] as String,
      valkey: json['valkey'] as String,
      website: json['website'] as String?,
      logo: json['logo'] as String?,
    );
  }

  @override
  List<Object?> get props => <Object?>[moniker, address, valkey, website, logo];
}