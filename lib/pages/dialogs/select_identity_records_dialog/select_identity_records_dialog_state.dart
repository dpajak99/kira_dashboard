import 'package:equatable/equatable.dart';
import 'package:kira_dashboard/models/identity_records.dart';

class SelectIdentityRecordsDialogState extends Equatable {
  final List<IdentityRecord> records;

  const SelectIdentityRecordsDialogState({
    required this.records,
  });

  @override
  List<Object?> get props => [records];
}
