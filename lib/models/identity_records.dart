import 'package:kira_dashboard/infra/entities/identity_registrar/identity_record_entity.dart';

class IdentityRecords {
  final IdentityRecord? username;
  final IdentityRecord? avatar;
  final IdentityRecord? description;
  final IdentityRecord? social;
  final List<IdentityRecord> other;

  IdentityRecords({
    this.username,
    this.avatar,
    this.description,
    this.social,
    this.other = const <IdentityRecord>[],
  });

  List<IdentityRecord> get all => <IdentityRecord>[
        if (username != null) username!,
        if (avatar != null) avatar!,
        if (description != null) description!,
        if (social != null) social!,
        ...other,
  ];
}

class IdentityRecord {
  final String id;
  final String key;
  final String value;
  final List<String> verifiers;

  IdentityRecord({
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
}
