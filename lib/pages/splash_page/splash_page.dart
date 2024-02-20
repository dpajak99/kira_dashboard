import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/config/predefined_networks.dart';
import 'package:kira_dashboard/pages/dialogs/network_dialog/network_cubit.dart';
import 'package:kira_dashboard/pages/dialogs/network_dialog/network_dialog.dart';
import 'package:kira_dashboard/pages/dialogs/network_dialog/network_state.dart';
import 'package:kira_dashboard/pages/dialogs/network_dialog/network_status.dart';
import 'package:kira_dashboard/pages/splash_page/splash_page_cubit.dart';
import 'package:kira_dashboard/pages/splash_page/splash_page_state.dart';
import 'package:kira_dashboard/utils/network_utils.dart';
import 'package:kira_dashboard/utils/router/router.gr.dart';
import 'package:kira_dashboard/widgets/address_text.dart';
import 'package:kira_dashboard/widgets/background.dart';
import 'package:kira_dashboard/widgets/custom_dialog.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  final PageRouteInfo? routeInfo;

  const SplashPage({
    super.key,
    this.routeInfo,
  });

  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final TextEditingController controller = TextEditingController();
  late final SplashPageCubit splashPageCubit = SplashPageCubit.initializeConnection(successCallback: _handleSuccessConnection);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return BlocBuilder<SplashPageCubit, SplashPageState>(
      bloc: splashPageCubit,
      builder: (BuildContext context, SplashPageState state) {
        if (state is ConnectingState) {
          return Scaffold(
            body: Background(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'MIRO 看 (見る)',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.notoSans(color: const Color(0xfffbfbfb), fontSize: 32),
                  ),
                  const SizedBox(height: 16),
                  Image.asset(
                    'logo_loading.gif',
                    height: 200,
                    cacheHeight: 200,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Connecting to: ${state.network.name} (${state.network.interxUrl.toString()})',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.notoSans(color: const Color(0xfffbfbfb), fontSize: 15),
                  ),
                ],
              ),
            ),
          );
        } else if (state is DisconnectedState) {
          return Scaffold(
            body: Background(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: SingleChildScrollView(
                      child: SizedBox(
                        width: double.infinity,
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            constraints: BoxConstraints(maxWidth: min(MediaQuery.of(context).size.width, 400)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'logo_signet.png',
                                  height: 50,
                                  cacheHeight: 50,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'MIRO 看 (見る)',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.notoSans(color: const Color(0xfffbfbfb), fontSize: 32),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Connection with ${state.network.name} server failed',
                                  textAlign: TextAlign.center,
                                  style: textTheme.bodyMedium!.copyWith(
                                    color: const Color(0xfffbfbfb),
                                  ),
                                ),
                                Text(
                                  state.network.interxUrl.toString(),
                                  style: textTheme.labelMedium!.copyWith(
                                    color: const Color(0xff6c86ad),
                                  ),
                                ),
                                const SizedBox(height: 100),
                                Text(
                                  'Select a network to connect to:',
                                  textAlign: TextAlign.center,
                                  style: textTheme.bodyMedium!.copyWith(
                                    color: const Color(0xfffbfbfb),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                BlocBuilder<NetworkCubit, NetworkState>(
                                  bloc: getIt<NetworkCubit>(),
                                  builder: (BuildContext context, NetworkState state) {
                                    return Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 8),
                                          decoration: const BoxDecoration(
                                            color: Color(0xff0a0d15),
                                            borderRadius: BorderRadius.all(Radius.circular(16)),
                                          ),
                                          child: Column(
                                            children: [
                                              ...state.availableNetworks.map((NetworkStatus e) {
                                                return AvailableNetworkTile(
                                                  networkStatus: e,
                                                  onTap: () {
                                                    getIt<NetworkCubit>().connect(e);
                                                    _handleSuccessConnection();
                                                  },
                                                );
                                              }),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        Container(
                                          padding: const EdgeInsets.all(16),
                                          decoration: const BoxDecoration(
                                            color: Color(0xff0a0d15),
                                            borderRadius: BorderRadius.all(Radius.circular(16)),
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: TextField(
                                                  controller: controller,
                                                  style: textTheme.bodyMedium!.copyWith(color: const Color(0xfffbfbfb)),
                                                  cursorColor: const Color(0xfffbfbfb),
                                                  cursorWidth: 1,
                                                  decoration: InputDecoration(
                                                    contentPadding: EdgeInsets.zero,
                                                    isDense: true,
                                                    hintText: 'Custom address',
                                                    hintStyle: textTheme.bodyMedium!.copyWith(color: const Color(0xff3e4c63)),
                                                    border: InputBorder.none,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 16),
                                              IconTextButton(
                                                text: 'Add',
                                                highlightColor: const Color(0xfffbfbfb),
                                                style: textTheme.bodyMedium!.copyWith(color: const Color(0xff4888f0)),
                                                onTap: () {
                                                  try {
                                                    getIt<NetworkCubit>().addCustomNetwork(NetworkTemplate(
                                                      name: 'Custom',
                                                      custom: true,
                                                      interxUrl: NetworkUtils.formatUrl(controller.text),
                                                    ));
                                                  } finally {
                                                    controller.clear();
                                                  }
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  void _handleSuccessConnection() {
    print('Success callback');
    if (widget.routeInfo != null) {
      print('Navigate to ${widget.routeInfo}');
      AutoRouter.of(context).replace(widget.routeInfo!);
    } else {
      print('Navigate to MenuWrapperRoute');
      AutoRouter.of(context).replace(const MenuWrapperRoute());
    }
  }
}
