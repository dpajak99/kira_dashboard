import 'package:auto_route/annotations.dart';
import 'package:blockies_svg/blockies_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kira_dashboard/models/coin.dart';
import 'package:kira_dashboard/pages/portfolio_page/about_page/about_page.dart';
import 'package:kira_dashboard/pages/portfolio_page/balances_page/balances_page.dart';
import 'package:kira_dashboard/pages/portfolio_page/delegations_page/delegations_page.dart';
import 'package:kira_dashboard/pages/portfolio_page/portfolio_page_cubit.dart';
import 'package:kira_dashboard/pages/portfolio_page/portfolio_page_state.dart';
import 'package:kira_dashboard/pages/portfolio_page/transactions_page/transactions_page.dart';
import 'package:kira_dashboard/pages/portfolio_page/verification_requests_page/verification_requests_page_page.dart';
import 'package:kira_dashboard/widgets/avatar/identity_avatar.dart';
import 'package:kira_dashboard/widgets/custom_table.dart';
import 'package:kira_dashboard/widgets/token_icon.dart';

@RoutePage()
class PortfolioPage extends StatefulWidget {
  final String address;

  const PortfolioPage({
    @PathParam('address') this.address = '',
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  int selectedPage = 0;

  late final PortfolioPageCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = PortfolioPageCubit(address: widget.address)..init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PortfolioPageCubit, PortfolioPageState>(
      bloc: cubit,
      builder: (BuildContext context, PortfolioPageState state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 1000),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        IdentityAvatar(address: widget.address, size: 156),
                        const SizedBox(width: 32),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Wallet Overview',
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(),
                            Text(
                              '${widget.address.substring(0, 8)}...${widget.address.substring(widget.address.length - 8)}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xff6c86ad),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 32),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () => setState(() => selectedPage = 0),
                          child: Text(
                            'Balances',
                            style: TextStyle(color: selectedPage == 0 ? const Color(0xfffbfbfb) : null),
                          ),
                        ),
                        TextButton(
                          onPressed: () => setState(() => selectedPage = 1),
                          child: Text(
                            'Transactions',
                            style: TextStyle(color: selectedPage == 1 ? const Color(0xfffbfbfb) : null),
                          ),
                        ),
                        TextButton(
                          onPressed: () => setState(() => selectedPage = 2),
                          child: Text(
                            'Delegations',
                            style: TextStyle(color: selectedPage == 2 ? const Color(0xfffbfbfb) : null),
                          ),
                        ),
                        TextButton(
                          onPressed: () => setState(() => selectedPage = 3),
                          child: Text(
                            'Verification requests',
                            style: TextStyle(color: selectedPage == 3 ? const Color(0xfffbfbfb) : null),
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () => setState(() => selectedPage = 4),
                          label: Text(
                            'About',
                            style: TextStyle(color: selectedPage == 4 ? const Color(0xfffbfbfb) : null),
                          ),
                          icon: Icon(Icons.info_outline, size: 16, color: selectedPage == 4 ? const Color(0xfffbfbfb) : null),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    if (selectedPage == 0) BalancesPage(state: state),
                    if (selectedPage == 1) TransactionsPage(state: state),
                    if (selectedPage == 2) DelegationsPage(state: state),
                    if (selectedPage == 3) VerificationRequestsPage(state: state),
                    if (selectedPage == 4) AboutPage(state: state, address: widget.address),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
