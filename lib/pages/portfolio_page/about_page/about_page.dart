import 'package:flutter/material.dart';
import 'package:kira_dashboard/config/app_icons.dart';
import 'package:kira_dashboard/models/identity_records.dart';
import 'package:kira_dashboard/models/validator.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_route.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/delegate_tokens_dialog/delegate_tokens_dialog.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/delete_identity_records_dialog/delete_identity_records_dialog.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/register_identity_records_dialog/register_identity_records_dialog.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/verify_identity_records_dialog/verify_identity_records_dialog.dart';
import 'package:kira_dashboard/pages/portfolio_page/portfolio_page_state.dart';
import 'package:kira_dashboard/widgets/address_text.dart';
import 'package:kira_dashboard/widgets/avatar/identity_avatar.dart';
import 'package:kira_dashboard/widgets/custom_card.dart';
import 'package:kira_dashboard/widgets/custom_table.dart';
import 'package:kira_dashboard/widgets/user_type_chip.dart';
import 'package:url_recognizer/url_recognizer.dart';

class AboutPage extends StatelessWidget {
  final String address;
  final PortfolioPageState state;

  const AboutPage({
    super.key,
    required this.address,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    List<String> socialUrls = state.identityRecords.social?.value.split(',') ?? <String>[];
    List<SocialUrl> socials = socialUrls.map((String url) => UrlRecognizer.findObject(url: url)).toList();

    return Column(
      children: [
        CustomCard(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IdentityAvatar(
                      address: address,
                      avatarUrl: state.identityRecords.avatar?.value,
                      size: 156,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      state.identityRecords.username?.value ?? '',
                      style: const TextStyle(fontSize: 24, color: Color(0xfffbfbfb)),
                    ),
                    Text(
                      '${address.substring(0, 8)}...${address.substring(address.length - 8)}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xff6c86ad),
                      ),
                    ),
                    const SizedBox(height: 8),
                    UserTypeChip(
                      userType: state.validator != null ? UserType.validator : UserType.user,
                      alignment: Alignment.center,
                    ),
                    const SizedBox(height: 8),
                    const Divider(color: Color(0xff222b3a)),
                    const SizedBox(height: 8),
                    Wrap(
                      children: socials.map((SocialUrl e) {
                        return IconButton(onPressed: () {}, icon: Icon(e.icon), visualDensity: VisualDensity.compact);
                      }).toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('About', style: TextStyle(fontSize: 24)),
                    const SizedBox(height: 24),
                    Text(
                      state.identityRecords.description?.value ?? '',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        if (state.validator != null) ...<Widget>[
          CustomCard(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const Text(
                      'STATUS',
                      style: TextStyle(
                        fontSize: 24,
                        color: Color(0xff6c86ad),
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      switch (state.validator!.status) {
                        ValidatorStatus.active => 'ACTIVE',
                        ValidatorStatus.inactive => 'INACTIVE',
                        ValidatorStatus.jailed => 'JAILED',
                        ValidatorStatus.paused => 'PAUSED',
                      },
                      style: TextStyle(
                        fontSize: 28,
                        color: switch (state.validator!.status) {
                          ValidatorStatus.active => const Color(0xff35b15f),
                          ValidatorStatus.inactive => const Color(0xffffa500),
                          ValidatorStatus.jailed => const Color(0xfff12e1f),
                          ValidatorStatus.paused => const Color(0xfff12e1f),
                        },
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    const Text(
                      'POOL',
                      style: TextStyle(
                        fontSize: 24,
                        color: Color(0xff6c86ad),
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      switch (state.validator!.stakingPoolStatus) {
                        StakingPoolStatus.withdraw => 'WITHDRAW',
                        StakingPoolStatus.disabled => 'DISABLED',
                        StakingPoolStatus.enabled => 'ENABLED',
                      },
                      style: TextStyle(
                        fontSize: 28,
                        color: switch (state.validator!.stakingPoolStatus) {
                          StakingPoolStatus.withdraw => const Color(0xffffa500),
                          StakingPoolStatus.disabled => const Color(0xfff12e1f),
                          StakingPoolStatus.enabled => const Color(0xff35b15f),
                        },
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    const Text(
                      'STREAK',
                      style: TextStyle(
                        fontSize: 24,
                        color: Color(0xff6c86ad),
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.validator!.streak,
                      style: const TextStyle(
                        fontSize: 28,
                        color: Color(0xfffbfbfb),
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    const Text(
                      'UPTIME',
                      style: TextStyle(
                        fontSize: 24,
                        color: Color(0xff6c86ad),
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${state.validator!.uptime}%',
                      style: const TextStyle(
                        fontSize: 28,
                        color: Color(0xfffbfbfb),
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
        CustomCard(
          title: 'Identity records',
          leading: Row(
            children: [
              if (state.isMyWallet)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: IconTextButton(
                    text: 'Add',
                    icon: AppIcons.add,
                    gap: 4,
                    highlightColor: const Color(0xfffbfbfb),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xff4888f0),
                    ),
                    onTap: () => DialogRouter().navigate(const RegisterIdentityRecordsDialog()),
                  ),
                ),
            ],
          ),
          child: CustomTable(
            items: state.identityRecords.all,
            columns: [
              ColumnConfig(
                title: 'Key',
                flex: 1,
                cellBuilder: (BuildContext context, IdentityRecord item) {
                  return Text(
                    item.key,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14, color: Color(0xfffbfbfb)),
                  );
                },
              ),
              ColumnConfig(
                title: 'Value',
                flex: 2,
                cellBuilder: (BuildContext context, IdentityRecord item) {
                  return Text(
                    item.value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14, color: Color(0xfffbfbfb)),
                  );
                },
              ),
              ColumnConfig(
                title: 'Status',
                cellBuilder: (BuildContext context, IdentityRecord item) {
                  return _VerificationChip(verified: item.verifiers.isNotEmpty);
                },
              ),
              if (state.isMyWallet)
                ColumnConfig(
                  title: 'Actions',
                  textAlign: TextAlign.right,
                  cellBuilder: (BuildContext context, IdentityRecord item) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconTextButton(
                          text: 'Edit',
                          highlightColor: const Color(0xfffbfbfb),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xff4888f0),
                          ),
                          onTap: () => DialogRouter().navigate(RegisterIdentityRecordsDialog(records: [item])),
                        ),
                        const SizedBox(width: 16),
                        IconTextButton(
                          text: 'Verify',
                          highlightColor: const Color(0xfffbfbfb),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xff4888f0),
                          ),
                          onTap: () => DialogRouter().navigate(VerifyIdentityRecordsDialog(records: [item],)),
                        ),
                        const SizedBox(width: 16),
                        IconTextButton(
                          text: 'Delete',
                          highlightColor: const Color(0xfffbfbfb),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xff4888f0),
                          ),
                          onTap: () => DialogRouter().navigate(DeleteIdentityRecordsDialog(records: [item])),
                        ),
                      ],
                    );
                  },
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _VerificationChip extends StatelessWidget {
  final bool verified;

  const _VerificationChip({required this.verified});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: switch (verified) {
            true => const Color(0x2935b15f),
            false => const Color(0x29f12e1f),
          },
        ),
        child: Text(
          verified ? 'Verified' : 'Unverified',
          style: TextStyle(
            fontSize: 12,
            color: switch (verified) {
              true => const Color(0xff35b15f),
              false => const Color(0xfff12e1f),
            },
          ),
        ),
      ),
    );
  }
}
