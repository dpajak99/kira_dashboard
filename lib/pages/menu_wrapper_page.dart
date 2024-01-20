import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/config/network_provider.dart';
import 'package:kira_dashboard/pages/dialogs/connect_wallet_dialog.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_page.dart';
import 'package:kira_dashboard/utils/router/router.gr.dart';
import 'package:kira_dashboard/widgets/wallet_button.dart';

@RoutePage()
class MenuWrapperPage extends StatelessWidget {
  const MenuWrapperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 200,
            height: double.infinity,
            color: const Color(0xff1a1f36),
            child: Column(
              children: [
                ListTile(
                  onTap: () => AutoRouter.of(context).navigate(const ValidatorsRoute()),
                  title: const Text('Validators'),
                ),
                ListTile(
                  onTap: () => AutoRouter.of(context).navigate(const BlocksRoute()),
                  title: const Text('Blocks'),
                ),
                ListTile(
                  onTap: () => AutoRouter.of(context).navigate(BlockTransactionsRoute()),
                  title: const Text('Transactions'),
                ),
                ListTile(
                  onTap: () => AutoRouter.of(context).navigate(const ProposalsRoute()),
                  title: const Text('Proposals'),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 8),
                  child: Row(
                    children: [
                      SvgPicture.asset('logo_light.svg', height: 40),
                      const SizedBox(width: 40),
                      Container(
                        constraints: const BoxConstraints(maxWidth: 300, minWidth: 100),
                        decoration: const BoxDecoration(
                          color: Color(0xff11141c),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.search,
                              color: Color(0xff47546d),
                            ),
                            SizedBox(width: 8),
                            Text(
                              "Search for address",
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xff47546d),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        decoration: const BoxDecoration(
                          color: Color(0xff4888f0),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.network_wifi_rounded,
                              size: 18,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'localnet-1',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      const WalletButton(),
                      const SizedBox(width: 8),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
                    ],
                  ),
                ),
                const Expanded(
                  child: Center(
                    child: AutoRouter(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
