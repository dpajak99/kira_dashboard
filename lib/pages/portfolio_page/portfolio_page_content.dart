import 'package:flutter/material.dart';
import 'package:kira_dashboard/config/theme/app_colors.dart';
import 'package:kira_dashboard/models/identity_records.dart';
import 'package:kira_dashboard/models/validator.dart';
import 'package:kira_dashboard/pages/portfolio_page/balances_page/balances_page.dart';
import 'package:kira_dashboard/pages/portfolio_page/delegations_page/delegations_page.dart';
import 'package:kira_dashboard/pages/portfolio_page/identity_records_page/identity_records_page.dart';
import 'package:kira_dashboard/pages/portfolio_page/transactions_page/transactions_page.dart';
import 'package:kira_dashboard/pages/portfolio_page/validator_info_page/validator_info_page.dart';
import 'package:kira_dashboard/pages/portfolio_page/verification_requests_page/verification_requests_page.dart';
import 'package:kira_dashboard/widgets/address_text.dart';
import 'package:kira_dashboard/widgets/avatar/identity_avatar.dart';
import 'package:kira_dashboard/widgets/mouse_state_listener.dart';
import 'package:kira_dashboard/widgets/openable_text.dart';
import 'package:kira_dashboard/widgets/page_scaffold.dart';
import 'package:kira_dashboard/widgets/sliver_tab_bar_view.dart';
import 'package:kira_dashboard/widgets/user_type_chip.dart';
import 'package:url_recognizer/url_recognizer.dart';

class PortfolioPageContent extends StatefulWidget {
  final bool isValidator;
  final bool isMyWallet;
  final String address;
  final bool isFavourite;
  final VoidCallback onAddFavourite;
  final VoidCallback onRemoveFavourite;
  final IdentityRecords identityRecords;
  final Validator? validator;

  const PortfolioPageContent({
    required this.isValidator,
    required this.isMyWallet,
    required this.address,
    required this.isFavourite,
    required this.onAddFavourite,
    required this.onRemoveFavourite,
    required this.identityRecords,
    required this.validator,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _PortfolioPageContentState();
}

class _PortfolioPageContentState extends State<PortfolioPageContent> with SingleTickerProviderStateMixin {
  late final TabController tabController = TabController(length: widget.isValidator ? 6 : 5, vsync: this);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    List<String> socialUrls = widget.identityRecords.social?.value.split(',') ?? <String>[];
    List<SocialUrl> socials = socialUrls.map((String url) => UrlRecognizer.findObject(url: url)).toList();

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
                      style: textTheme.headlineLarge!.copyWith(color: CustomColors.white),
                    ),
                    if (MediaQuery.of(context).size.width > 600) CopyableAddressText(address: widget.address, dark: true, full: true)
                  ],
                ),
              ),
              TrustAddressStar(
                isFavourite: widget.isFavourite,
                onAdd: widget.onAddFavourite,
                onRemove: widget.onRemoveFavourite,
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
                avatarUrl: widget.identityRecords.avatar?.value ?? widget.validator?.logo,
                size: MediaQuery.of(context).size.width > 600 ? 130 : 120,
              ),
              const SizedBox(width: 32),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        if (widget.isValidator) ...<Widget>[
                          RankChip(rank: widget.validator!.top),
                          const SizedBox(width: 8),
                        ],
                        UserTypeChip(userType: widget.isValidator ? UserType.validator : UserType.user),
                        if (widget.isMyWallet) ...<Widget>[
                          const SizedBox(width: 8),
                          const UserTypeChip(userType: UserType.yourAccount, alignment: Alignment.centerRight),
                        ],
                        if (widget.validator?.website != null) ...<Widget>[
                          const SizedBox(width: 16),
                          OpenableText(
                            text: 'Website',
                            onTap: () {},
                            style: textTheme.bodyMedium!.copyWith(
                              color: CustomColors.secondary,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.identityRecords.getName(widget.isValidator) ?? '---',
                          style: textTheme.headlineLarge!.copyWith(color: CustomColors.white),
                        ),
                        if (widget.identityRecords.isUsernameTrusted()) ...<Widget>[
                          const SizedBox(width: 8),
                          Tooltip(
                            message: 'Verified by your trusted addresses:\n- ${widget.identityRecords.username!.trustedVerifiers.join('\n- ')}',
                            child: const Icon(Icons.verified, color: CustomColors.primary),
                          ),
                        ],
                      ],
                    ),
                    CopyableAddressText(address: widget.address, dark: true),
                    const SizedBox(height: 16),
                    Wrap(
                      children: socials.map((SocialUrl e) {
                        return MouseStateListener(childBuilder: (Set<WidgetState> states) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Icon(
                              e.icon,
                              size: 24,
                              color: states.contains(WidgetState.hovered) ? CustomColors.white : CustomColors.secondary,
                            ),
                          );
                        });
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.only(bottom: 16, top: 32),
          sliver: SliverToBoxAdapter(
            child: TabBar(
              tabController: tabController,
              tabs: [
                if (widget.validator != null) 'Info',
                'Balances',
                'Transactions',
                'Delegations',
                'Verification requests',
                'Identity records',
              ],
            ),
          ),
        ),
        SliverTabBarView(
          tabController: tabController,
          children: [
            if (widget.validator != null) ValidatorInfoPage(validator: widget.validator!),
            BalancesPage(address: widget.address, isMyWallet: widget.isMyWallet),
            TransactionsPage(address: widget.address, isMyWallet: widget.isMyWallet),
            DelegationsPage(address: widget.address, isMyWallet: widget.isMyWallet),
            VerificationRequestsPage(address: widget.address, isMyWallet: widget.isMyWallet),
            IdentityRecordsPage(address: widget.address, isMyWallet: widget.isMyWallet),
          ],
        ),
      ],
    );
  }
}

class TabBar extends StatelessWidget {
  final TabController tabController;
  final List<String> tabs;

  const TabBar({
    required this.tabController,
    required this.tabs,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return ListenableBuilder(
      listenable: tabController,
      builder: (BuildContext context, _) {
        return Wrap(
          children: [
            for (int i = 0; i < tabs.length; i++) ...<Widget>[
              TextButton(
                onPressed: () => tabController.animateTo(i),
                style: TextButton.styleFrom(
                  textStyle: textTheme.bodyMedium!,
                  foregroundColor: tabController.index == i ? CustomColors.white : CustomColors.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(tabs[i]),
              )
            ],
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
        color: CustomColors.primary,
      ),
      child: Text(
        'Rank #$rank',
        style: textTheme.labelLarge!.copyWith(color: CustomColors.white),
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
        color: widget.isFavourite ? CustomColors.primary : CustomColors.white,
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
