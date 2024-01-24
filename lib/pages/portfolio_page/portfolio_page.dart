import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/pages/portfolio_page/about_page/about_page.dart';
import 'package:kira_dashboard/pages/portfolio_page/balances_page/balances_page.dart';
import 'package:kira_dashboard/pages/portfolio_page/delegations_page/delegations_page.dart';
import 'package:kira_dashboard/pages/portfolio_page/portfolio_page_cubit.dart';
import 'package:kira_dashboard/pages/portfolio_page/portfolio_page_state.dart';
import 'package:kira_dashboard/pages/portfolio_page/transactions_page/transactions_page.dart';
import 'package:kira_dashboard/pages/portfolio_page/verification_requests_page/verification_requests_page_page.dart';
import 'package:kira_dashboard/widgets/address_text.dart';
import 'package:kira_dashboard/widgets/avatar/identity_avatar.dart';
import 'package:kira_dashboard/widgets/mouse_state_listener.dart';
import 'package:kira_dashboard/widgets/page_scaffold.dart';
import 'package:kira_dashboard/widgets/sliver_page_padding.dart';
import 'package:kira_dashboard/widgets/user_type_chip.dart';
import 'package:url_recognizer/url_recognizer.dart';

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
        List<String> socialUrls = state.identityRecords.social?.value.split(',') ?? <String>[];
        List<SocialUrl> socials = socialUrls.map((String url) => UrlRecognizer.findObject(url: url)).toList();

        return PageScaffold(
          slivers: [
            SliverPagePadding(
              sliver: SliverToBoxAdapter(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Address overview',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              color: Color(0xfffbfbfb),
                            ),
                          ),
                          CopyableText(
                            text: widget.address,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xff6c86ad),
                            ),
                          )
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.share,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SliverPadding(padding: EdgeInsets.only(top: 32)),
            SliverPagePadding(
              sliver: SliverToBoxAdapter(
                child: Row(
                  children: [
                    IdentityAvatar(
                      address: widget.address,
                      avatarUrl: state.identityRecords.avatar?.value,
                      size: 156,
                    ),
                    const SizedBox(width: 32),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            UserTypeChip(userType: state.validator != null ? UserType.validator : UserType.user),
                            if (state.isMyWallet) ...<Widget>[
                              const SizedBox(width: 8),
                              const UserTypeChip(userType: UserType.yourAccount, alignment: Alignment.centerRight),
                            ],
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          state.identityRecords.username?.value ?? '---',
                          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                        ),
                        CopyableAddressText(
                          address: widget.address,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xff6c86ad),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          children: socials.map((SocialUrl e) {
                            return MouseStateListener(childBuilder: (Set<MaterialState> states) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Icon(
                                  e.icon,
                                  size: 24,
                                  color: states.contains(MaterialState.hovered) ? const Color(0xfffbfbfb) : const Color(0xff6c86ad),
                                ),
                              );
                            });
                          }).toList(),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SliverPadding(padding: EdgeInsets.symmetric(vertical: 24)),
            SliverPagePadding(
              sliver: SliverPadding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                sliver: SliverToBoxAdapter(
                  child: Row(
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
                        icon: Icon(Icons.info_outline, size: 14, color: selectedPage == 4 ? const Color(0xfffbfbfb) : null),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (selectedPage == 0) SliverPagePadding(sliver: SliverToBoxAdapter(child: BalancesPage(address: widget.address, isMyWallet: state.isMyWallet))),
            if (selectedPage == 1) SliverPagePadding(sliver: SliverToBoxAdapter(child: TransactionsPage(address: widget.address, isMyWallet: state.isMyWallet))),
            if (selectedPage == 2) SliverPagePadding(sliver: SliverToBoxAdapter(child: DelegationsPage(address: widget.address, isMyWallet: state.isMyWallet))),
            if (selectedPage == 3) SliverPagePadding(sliver: SliverToBoxAdapter(child: VerificationRequestsPage(state: state))),
            if (selectedPage == 4) SliverPagePadding(sliver: SliverToBoxAdapter(child: AboutPage(state: state, address: widget.address))),
          ],
        );
      },
    );
  }
}
