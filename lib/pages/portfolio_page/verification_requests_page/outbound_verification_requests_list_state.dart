import 'package:kira_dashboard/models/verification_request.dart';
import 'package:kira_dashboard/pages/page_state.dart';

class OutboundVerificationRequestsListState extends PageState {
  final int pageSize = 10;
  final List<VerificationRequest> requests;

  const OutboundVerificationRequestsListState({
    this.requests = const <VerificationRequest>[],
    required super.isLoading,
  });

  OutboundVerificationRequestsListState copyWith({
    bool? isLoading,
    List<VerificationRequest>? requests,
  }) {
    return OutboundVerificationRequestsListState(
      isLoading: isLoading ?? this.isLoading,
      requests: requests ?? this.requests,
    );
  }

  @override
  List<Object?> get props => [requests, isLoading];
}
