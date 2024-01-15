import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kira_dashboard/models/identity_records.dart';
import 'package:kira_dashboard/pages/portfolio_page/portfolio_page_state.dart';
import 'package:kira_dashboard/widgets/avatar/identity_avatar.dart';
import 'package:kira_dashboard/widgets/custom_card.dart';
import 'package:kira_dashboard/widgets/custom_table.dart';
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

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: CustomCard(
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
                    fontSize: 16,
                    color: Color(0xff6c86ad),
                  ),
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
        ),
        const SizedBox(width: 20),
        Expanded(
          flex: 2,
          child: Column(
            children: [
              CustomCard(
                title: 'About',
                child: Text(
                  state.identityRecords.description?.value ?? '',
                ),
              ),
              const SizedBox(height: 20),
              CustomCard(
                title: 'Identity records',
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
                          style: const TextStyle(fontSize: 16, color: Color(0xfffbfbfb)),
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
                          style: const TextStyle(fontSize: 16, color: Color(0xfffbfbfb)),
                        );
                      },
                    ),
                    ColumnConfig(
                      title: 'Status',
                      cellBuilder: (BuildContext context, IdentityRecord item) {
                        return _VerificationChip(verified: item.verifiers.isNotEmpty);
                      },
                    ),
                    ColumnConfig(
                      title: 'Actions',
                      textAlign: TextAlign.right,
                      cellBuilder: (BuildContext context, IdentityRecord item) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.info_outline, size: 20, color: Color(0xff2f8af5)),
                              visualDensity: VisualDensity.compact,
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
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
