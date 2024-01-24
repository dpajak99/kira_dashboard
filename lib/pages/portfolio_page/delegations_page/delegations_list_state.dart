import 'package:kira_dashboard/models/delegation.dart';
import 'package:kira_dashboard/pages/page_state.dart';

class DelegationsListState extends PageState {
  final int pageSize = 10;
  final List<Delegation> delegations;

  const DelegationsListState({
    this.delegations = const <Delegation>[],
    required super.isLoading,
  });

  DelegationsListState copyWith({
    bool? isLoading,
    List<Delegation>? delegations,
  }) {
    return DelegationsListState(
      isLoading: isLoading ?? this.isLoading,
      delegations: delegations ?? this.delegations,
    );
  }

  @override
  List<Object?> get props => [delegations, isLoading];
}
