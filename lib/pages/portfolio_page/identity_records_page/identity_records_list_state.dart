import 'package:kira_dashboard/models/identity_records.dart';
import 'package:kira_dashboard/pages/page_state.dart';

class IdentityRecordsListState extends PageState {
  final List<IdentityRecord> records;

  const IdentityRecordsListState({
    this.records = const <IdentityRecord>[],
    required super.isLoading,
  });

  IdentityRecordsListState copyWith({
    bool? isLoading,
    List<IdentityRecord>? records,
  }) {
    return IdentityRecordsListState(
      isLoading: isLoading ?? this.isLoading,
      records: records ?? this.records,
    );
  }

  @override
  List<Object?> get props => [records, isLoading];
}
