import 'package:kira_dashboard/models/verification_request.dart';
import 'package:kira_dashboard/pages/page_state.dart';

class InboundVerificationRequestsListState extends PageState {
  final int pageSize = 10;
  final List<VerificationRequest> requests;

  const InboundVerificationRequestsListState({
    this.requests = const <VerificationRequest>[],
    required super.isLoading,
  });

  InboundVerificationRequestsListState copyWith({
    bool? isLoading,
    List<VerificationRequest>? requests,
  }) {
    return InboundVerificationRequestsListState(
      isLoading: isLoading ?? this.isLoading,
      requests: requests ?? this.requests,
    );
  }

  @override
  List<Object?> get props => [requests, isLoading];
}
