import 'package:flutter/material.dart';
import 'package:kira_dashboard/pages/portfolio_page/verification_requests_page/inbound_verification_requests_list.dart';
import 'package:kira_dashboard/pages/portfolio_page/verification_requests_page/inbound_verification_requests_list_cubit.dart';
import 'package:kira_dashboard/pages/portfolio_page/verification_requests_page/outbound_verification_requests_list.dart';
import 'package:kira_dashboard/pages/portfolio_page/verification_requests_page/outbound_verification_requests_list_cubit.dart';
import 'package:kira_dashboard/widgets/custom_card.dart';
import 'package:kira_dashboard/widgets/sliver_custom_card.dart';
import 'package:sliver_tools/sliver_tools.dart';

class VerificationRequestsPage extends StatefulWidget {
  final String address;
  final bool isMyWallet;

  const VerificationRequestsPage({
    super.key,
    required this.address,
    required this.isMyWallet,
  });

  @override
  State<StatefulWidget> createState() => _VerificationRequestsPageState();
}

class _VerificationRequestsPageState extends State<VerificationRequestsPage> {
  late final InboundVerificationRequestsListCubit inboundCubit =
      InboundVerificationRequestsListCubit(address: widget.address);
  late final OutboundVerificationRequestsListCubit outboundCubit =
      OutboundVerificationRequestsListCubit(address: widget.address);

  @override
  Widget build(BuildContext context) {
    return MultiSliver(
      children: [
        SliverCustomCard(
          title: 'Inbound',
          enableMobile: true,
          sliver: InboundVerificationRequestsList(
            isMyWallet: widget.isMyWallet,
            cubit: inboundCubit,
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 32)),
        SliverCustomCard(
          title: 'Outbound',
          enableMobile: true,
          sliver: OutboundVerificationRequestsList(
            isMyWallet: widget.isMyWallet,
            cubit: outboundCubit,
          ),
        ),
      ],
    );
  }
}
