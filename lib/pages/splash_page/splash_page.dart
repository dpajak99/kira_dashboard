import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/config/predefined_networks.dart';
import 'package:kira_dashboard/config/theme/app_colors.dart';
import 'package:kira_dashboard/pages/dialogs/network_dialog/network_cubit.dart';
import 'package:kira_dashboard/pages/dialogs/network_dialog/network_dialog.dart';
import 'package:kira_dashboard/pages/dialogs/network_dialog/network_state.dart';
import 'package:kira_dashboard/pages/dialogs/network_dialog/network_status.dart';
import 'package:kira_dashboard/pages/splash_page/splash_page_cubit.dart';
import 'package:kira_dashboard/pages/splash_page/splash_page_state.dart';
import 'package:kira_dashboard/utils/network_utils.dart';
import 'package:kira_dashboard/utils/router/router.gr.dart';
import 'package:kira_dashboard/widgets/address_text.dart';
import 'package:kira_dashboard/widgets/background_gradient.dart';

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
  late final SplashPageCubit splashPageCubit = SplashPageCubit.initializeConnection(successCallback: _navigateToNextPage);

  @override
  void initState() {
    super.initState();
    splashPageCubit.init();
  }

  @override
  void dispose() {
    splashPageCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundGradient(
        child: BlocBuilder<SplashPageCubit, SplashPageState>(
          bloc: splashPageCubit,
          builder: (BuildContext context, SplashPageState state) {
            if (state is ConnectingState) {
              return _ConnectingView(
                network: state.network,
                onCancel: splashPageCubit.cancelConnection,
              );
            } else if (state is DisconnectedState) {
              return _NetworkListView(
                network: state.network,
                onConnect: _onNetworkListConnect,
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }

  void _onNetworkListConnect(NetworkStatus network) {
    getIt<NetworkCubit>().connect(network);
    _navigateToNextPage();
  }

  void _navigateToNextPage() {
    if (widget.routeInfo != null) {
      AutoRouter.of(context).replace(widget.routeInfo!);
    } else {
      AutoRouter.of(context).replace(const MenuWrapperRoute());
    }
  }
}

class _ConnectingView extends StatelessWidget {
  final NetworkTemplate network;
  final VoidCallback onCancel;

  const _ConnectingView({
    required this.network,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'MIRO 看 (見る)',
          textAlign: TextAlign.center,
          style: GoogleFonts.notoSans(color: CustomColors.white, fontSize: 32),
        ),
        const SizedBox(height: 16),
        Image.asset(
          'logo_loading.gif',
          height: 200,
          cacheHeight: 200,
        ),
        const SizedBox(height: 16),
        Text(
          'Connecting to: ${network.name} (${network.interxUrl.toString()})',
          textAlign: TextAlign.center,
          style: GoogleFonts.notoSans(color: CustomColors.white, fontSize: 15),
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: onCancel,
          child: const Text('Cancel connection'),
        ),
      ],
    );
  }
}

class _NetworkListView extends StatefulWidget {
  final NetworkTemplate network;
  final ValueChanged<NetworkStatus> onConnect;

  const _NetworkListView({
    required this.network,
    required this.onConnect,
  });

  @override
  State<StatefulWidget> createState() => _NetworkListViewState();
}

class _NetworkListViewState extends State<_NetworkListView> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
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
                        style: GoogleFonts.notoSans(color: CustomColors.white, fontSize: 32),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Connection with ${widget.network.name} server failed',
                        textAlign: TextAlign.center,
                        style: textTheme.bodyMedium!.copyWith(
                          color: CustomColors.white,
                        ),
                      ),
                      Text(
                        widget.network.interxUrl.toString(),
                        style: textTheme.labelMedium!.copyWith(
                          color: CustomColors.secondary,
                        ),
                      ),
                      const SizedBox(height: 100),
                      Text(
                        'Select a network to connect to:',
                        textAlign: TextAlign.center,
                        style: textTheme.bodyMedium!.copyWith(
                          color: CustomColors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      BlocBuilder<NetworkCubit, NetworkState>(
                        bloc: getIt<NetworkCubit>(),
                        buildWhen: (NetworkState previous, NetworkState current) {
                          return current.isConnected == false;
                        },
                        builder: (BuildContext context, NetworkState state) {
                          return Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 8),
                                decoration: const BoxDecoration(
                                  color: CustomColors.container,
                                  borderRadius: BorderRadius.all(Radius.circular(16)),
                                ),
                                child: Column(
                                  children: [
                                    ...state.availableNetworks.map(
                                      (NetworkStatus e) {
                                        return AvailableNetworkTile(
                                          networkStatus: e,
                                          onTap: () => widget.onConnect(e),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: const BoxDecoration(
                                  color: CustomColors.container,
                                  borderRadius: BorderRadius.all(Radius.circular(16)),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: controller,
                                        style: textTheme.bodyMedium!.copyWith(color: CustomColors.white),
                                        cursorColor: CustomColors.white,
                                        cursorWidth: 1,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.zero,
                                          isDense: true,
                                          hintText: 'Custom address',
                                          hintStyle: textTheme.bodyMedium!.copyWith(color: CustomColors.container),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    SimpleTextButton(
                                      text: 'Add',
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
    );
  }
}
