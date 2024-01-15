import 'package:equatable/equatable.dart';

class IdentityRecordEntity extends Equatable {
  final String address;
  final String date;
  final String id;
  final String key;
  final String value;
  final List<String> verifiers;

  const IdentityRecordEntity({
    required this.address,
    required this.date,
    required this.id,
    required this.key,
    required this.value,
    required this.verifiers,
  });

  factory IdentityRecordEntity.fromJson(Map<String, dynamic> json) {
    return IdentityRecordEntity(
      address: json['address'] as String,
      date: json['date'] as String,
      id: json['id'] as String,
      key: json['key'] as String,
      value: json['value'] as String,
      verifiers: (json['verifiers'] as List<dynamic>).map((dynamic e) => e as String).toList(),
    );
  }

  @override
  List<Object?> get props => <Object?>[address, date, id, key, value, verifiers];
}
