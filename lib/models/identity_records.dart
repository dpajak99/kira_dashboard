import 'package:equatable/equatable.dart';
import 'package:kira_dashboard/infra/entities/identity_registrar/identity_record_entity.dart';

class IdentityRecords {
  final IdentityRecord? username;
  final IdentityRecord? moniker;
  final IdentityRecord? avatar;
  final IdentityRecord? description;
  final IdentityRecord? social;
  final List<IdentityRecord> other;

  IdentityRecords({
    this.username,
    this.moniker,
    this.avatar,
    this.description,
    this.social,
    this.other = const <IdentityRecord>[],
  });

  String? getName(bool validator) {
    if (validator) {
      return moniker?.value ?? username?.value;
    } else {
      return username?.value;
    }
  }

  List<IdentityRecord> get all => <IdentityRecord>[
        if (username != null) username!,
        if (moniker != null) moniker!,
        if (avatar != null) avatar!,
        if (description != null) description!,
        if (social != null) social!,
        ...other,
  ];
}

class IdentityRecord extends Equatable {
  final String id;
  final String key;
  final String value;
  final List<String> verifiers;

  const IdentityRecord({
    required this.id,
    required this.key,
    required this.value,
    required this.verifiers,
  });

  factory IdentityRecord.fromEntity(IdentityRecordEntity entity) {
    return IdentityRecord(
      id: entity.id,
      key: entity.key,
      value: entity.value,
      verifiers: entity.verifiers,
    );
  }

  @override
  List<Object?> get props => [id, key, value, verifiers];
}
