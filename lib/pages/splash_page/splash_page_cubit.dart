import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/config/predefined_networks.dart';
import 'package:kira_dashboard/infra/services/network_service.dart';
import 'package:kira_dashboard/pages/dialogs/network_dialog/network_cubit.dart';
import 'package:kira_dashboard/pages/dialogs/network_dialog/network_status.dart';
import 'package:kira_dashboard/pages/splash_page/splash_page_state.dart';

class SplashPageCubit extends Cubit<SplashPageState> {
  final NetworkCubit networkCubit = getIt<NetworkCubit>();
  final NetworkService networkService = NetworkService();
  final VoidCallback successCallback;

  SplashPageCubit.fromState({
    required this.successCallback,
    required SplashPageState state,
  }) : super(state) {
    init();
  }

  factory SplashPageCubit.initializeConnection({
    required VoidCallback successCallback,
  }) {
    NetworkTemplate defaultNetwork = PredefinedNetworks.defaultNetwork;
    return SplashPageCubit.fromState(
      state: ConnectingState(network: defaultNetwork),
      successCallback: successCallback,
    );
  }

  Future<void> init() async {
    if (state is! ConnectingState) return;

    NetworkTemplate defaultNetwork = (state as ConnectingState).network;
    NetworkStatus networkStatus = await networkService.getStatusForNetwork(defaultNetwork);
    networkCubit.init();

    if (networkStatus.isOnline) {
      await networkCubit.connect(networkStatus);
      successCallback.call();
    } else {
      emit(DisconnectedState(network: defaultNetwork));
    }
  }
}
