import 'package:kira_dashboard/models/undelegation.dart';
import 'package:kira_dashboard/pages/page_state.dart';

class UndelegationsListState extends PageState {
  final int pageSize = 10;
  final List<Undelegation> undelegations;

  const UndelegationsListState({
    this.undelegations = const <Undelegation>[],
    required super.isLoading,
  });

  UndelegationsListState copyWith({
    bool? isLoading,
    List<Undelegation>? undelegations,
  }) {
    return UndelegationsListState(
      isLoading: isLoading ?? this.isLoading,
      undelegations: undelegations ?? this.undelegations,
    );
  }

  @override
  List<Object?> get props => [undelegations, isLoading];
}
