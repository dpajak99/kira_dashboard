import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/pages/portfolio_page/balances_page/balances_page.dart';
import 'package:kira_dashboard/pages/portfolio_page/delegations_page/delegations_page.dart';
import 'package:kira_dashboard/pages/portfolio_page/identity_records_page/identity_records_page.dart';
import 'package:kira_dashboard/pages/portfolio_page/portfolio_page_cubit.dart';
import 'package:kira_dashboard/pages/portfolio_page/portfolio_page_state.dart';
import 'package:kira_dashboard/pages/portfolio_page/transactions_page/transactions_page.dart';
import 'package:kira_dashboard/pages/portfolio_page/validator_info_page/validator_info_page.dart';
import 'package:kira_dashboard/pages/portfolio_page/verification_requests_page/verification_requests_page.dart';
import 'package:kira_dashboard/widgets/address_text.dart';
import 'package:kira_dashboard/widgets/avatar/identity_avatar.dart';
import 'package:kira_dashboard/widgets/mouse_state_listener.dart';
import 'package:kira_dashboard/widgets/openable_text.dart';
import 'package:kira_dashboard/widgets/page_scaffold.dart';
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
  late final PortfolioPageCubit cubit = PortfolioPageCubit(address: widget.address);

  int selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return BlocBuilder<PortfolioPageCubit, PortfolioPageState>(
      bloc: cubit,
      builder: (BuildContext context, PortfolioPageState state) {
        List<String> socialUrls = state.identityRecords.social?.value.split(',') ?? <String>[];
        List<SocialUrl> socials = socialUrls.map((String url) => UrlRecognizer.findObject(url: url)).toList();
        int additionalPagesCount = state.validator != null ? 1 : 0;

        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xff2f8af5),
              strokeWidth: 2,
            ),
          );
        }

        return PageScaffold(
          slivers: [
            SliverToBoxAdapter(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Address overview',
                          style: textTheme.headlineLarge!.copyWith(color: const Color(0xfffbfbfb)),
                        ),
                        CopyableText(
                          text: widget.address,
                          style: textTheme.titleLarge!.copyWith(color: const Color(0xff6c86ad)),
                        )
                      ],
                    ),
                  ),
                  TrustAddressStar(
                    isFavourite: state.isFavourite,
                    onAdd: cubit.addFavourite,
                    onRemove: cubit.removeFavourite,
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
            const SliverPadding(padding: EdgeInsets.only(top: 32)),
            SliverToBoxAdapter(
              child: Row(
                children: [
                  IdentityAvatar(
                    address: widget.address,
                    avatarUrl: state.identityRecords.avatar?.value ?? state.validator?.logo,
                    size: 130,
                  ),
                  const SizedBox(width: 32),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          if (state.validator != null) ...<Widget>[
                            RankChip(rank: state.validator!.top),
                            const SizedBox(width: 8),
                          ],
                          UserTypeChip(userType: state.validator != null ? UserType.validator : UserType.user),
                          if (state.isMyWallet) ...<Widget>[
                            const SizedBox(width: 8),
                            const UserTypeChip(userType: UserType.yourAccount, alignment: Alignment.centerRight),
                          ],
                          if (state.validator?.website != null) ...<Widget>[
                            const SizedBox(width: 16),
                            OpenableText(
                              text: 'Website',
                              onTap: () {},
                              style: textTheme.bodyMedium!.copyWith(
                                color: const Color(0xff6c86ad),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        state.identityRecords.getName(state.validator != null) ?? '---',
                        style: textTheme.headlineLarge!.copyWith(color: const Color(0xfffbfbfb)),
                      ),
                      CopyableAddressText(
                        address: widget.address,
                        style: textTheme.titleLarge!.copyWith(color: const Color(0xff6c86ad)),
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
            const SliverPadding(padding: EdgeInsets.symmetric(vertical: 24)),
            SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              sliver: SliverToBoxAdapter(
                child: Wrap(
                  children: [
                    if (state.validator != null)
                      TextButton.icon(
                        onPressed: () => setState(() => selectedPage = 0),
                        icon: Icon(
                          Icons.info_outline,
                          color: selectedPage == 0 ? const Color(0xfffbfbfb) : null,
                          size: 16,
                        ),
                        label: Text(
                          'Info',
                          style: TextStyle(color: selectedPage == 0 ? const Color(0xfffbfbfb) : null),
                        ),
                      ),
                    TextButton(
                      onPressed: () => setState(() => selectedPage = 0 + additionalPagesCount),
                      child: Text(
                        'Balances',
                        style: TextStyle(color: selectedPage == 0 + additionalPagesCount ? const Color(0xfffbfbfb) : null),
                      ),
                    ),
                    TextButton(
                      onPressed: () => setState(() => selectedPage = 1 + additionalPagesCount),
                      child: Text(
                        'Transactions',
                        style: TextStyle(color: selectedPage == 1 + additionalPagesCount ? const Color(0xfffbfbfb) : null),
                      ),
                    ),
                    TextButton(
                      onPressed: () => setState(() => selectedPage = 2 + additionalPagesCount),
                      child: Text(
                        'Delegations',
                        style: TextStyle(color: selectedPage == 2 + additionalPagesCount ? const Color(0xfffbfbfb) : null),
                      ),
                    ),
                    TextButton(
                      onPressed: () => setState(() => selectedPage = 3 + additionalPagesCount),
                      child: Text(
                        'Verification requests',
                        style: TextStyle(color: selectedPage == 3 + additionalPagesCount ? const Color(0xfffbfbfb) : null),
                      ),
                    ),
                    TextButton(
                      onPressed: () => setState(() => selectedPage = 4 + additionalPagesCount),
                      child: Text(
                        'Identity records',
                        style: TextStyle(color: selectedPage == 4 + additionalPagesCount ? const Color(0xfffbfbfb) : null),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (state.validator != null && selectedPage == 0) SliverToBoxAdapter(child: ValidatorInfoPage(validator: state.validator!)),
            if (selectedPage == 0 + additionalPagesCount) SliverToBoxAdapter(child: BalancesPage(address: widget.address, isMyWallet: state.isMyWallet)),
            if (selectedPage == 1 + additionalPagesCount) SliverToBoxAdapter(child: TransactionsPage(address: widget.address, isMyWallet: state.isMyWallet)),
            if (selectedPage == 2 + additionalPagesCount) SliverToBoxAdapter(child: DelegationsPage(address: widget.address, isMyWallet: state.isMyWallet)),
            if (selectedPage == 3 + additionalPagesCount)
              SliverToBoxAdapter(child: VerificationRequestsPage(address: widget.address, isMyWallet: state.isMyWallet)),
            if (selectedPage == 4 + additionalPagesCount) SliverToBoxAdapter(child: IdentityRecordsPage(address: widget.address, isMyWallet: state.isMyWallet)),
          ],
        );
      },
    );
  }
}

class RankChip extends StatelessWidget {
  final int rank;

  const RankChip({
    required this.rank,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xff2f8af5),
      ),
      child: Text(
        'Rank #$rank',
        style: textTheme.labelLarge!.copyWith(color: const Color(0xfffbfbfb)),
      ),
    );
  }
}


class TrustAddressStar extends StatefulWidget {
  final bool isFavourite;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const TrustAddressStar({
    required this.isFavourite,
    required this.onAdd,
    required this.onRemove,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _TrustAddressStarState();
}

class _TrustAddressStarState extends State<TrustAddressStar> {
  late bool isFavourite = widget.isFavourite;

  @override
  void didUpdateWidget(covariant TrustAddressStar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isFavourite != widget.isFavourite) {
      setState(() => isFavourite = widget.isFavourite);
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _handlePress,
      tooltip: isFavourite ? 'Untrust' : 'Trust',
      icon: Icon(
        widget.isFavourite ? Icons.shield : Icons.shield_outlined,
        size: 24,
        color: widget.isFavourite ? const Color(0xff2f8af5) : const Color(0xfffbfbfb),
      ),
    );
  }

  void _handlePress() {
    if (isFavourite) {
      widget.onRemove();
    } else {
      widget.onAdd();
    }
    setState(() => isFavourite = !isFavourite);
  }
}