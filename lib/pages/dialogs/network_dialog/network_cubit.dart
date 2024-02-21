import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/config/predefined_networks.dart';
import 'package:kira_dashboard/infra/services/network_service.dart';
import 'package:kira_dashboard/pages/dialogs/network_dialog/network_state.dart';
import 'package:kira_dashboard/pages/dialogs/network_dialog/network_status.dart';

class NetworkStatusNotifier extends ValueNotifier<NetworkStatus?> {
  final ValueNotifier<NetworkStatus?> refreshNotifier = ValueNotifier<NetworkStatus?>(null);
  final ValueNotifier<NetworkStatus?> changeNetworkNotifier = ValueNotifier<NetworkStatus?>(null);

  NetworkStatusNotifier() : super(null);

  void listen({
    ValueChanged<NetworkStatus?>? onChanged,
    ValueChanged<NetworkStatus?>? onRefresh,
  }) {
    refreshNotifier.addListener(() {
      if (onRefresh != null) {
        onRefresh(refreshNotifier.value);
      }
    });
    changeNetworkNotifier.addListener(() {
      if (onChanged != null) {
        onChanged(changeNetworkNotifier.value);
      }
    });
  }

  @override
  void dispose() {
    refreshNotifier.dispose();
    changeNetworkNotifier.dispose();
    super.dispose();
  }

  void notifyRefreshed(NetworkStatus? networkStatus) {
    refreshNotifier.value = networkStatus;
  }

  void notifyChanged(NetworkStatus? networkStatus) {
    changeNetworkNotifier.value = networkStatus;
  }
}

class NetworkCubit extends Cubit<NetworkState> {
  final NetworkService networkService = NetworkService();
  final NetworkStatusNotifier networkStatusNotifier = NetworkStatusNotifier();

  NetworkCubit() : super(NetworkState(availableNetworks: const [], currentNetwork: null)) {
    init();
  }

  void init() {
    List<NetworkTemplate> predefinedNetworks = PredefinedNetworks.networks;
    List<NetworkStatus> loadingNetworkStatuses = predefinedNetworks.map((e) {
      return NetworkStatus(
        name: e.name,
        interxUrl: e.interxUrl,
        status: NetworkStatusType.connecting,
      );
    }).toList();
    List<NetworkStatus> availableNetworks = loadingNetworkStatuses.where((e) => e.compareUri(state.currentNetwork?.interxUrl) == false).toList();
    emit(state.copyWith(availableNetworks: availableNetworks));
    refreshAll();
  }

  Future<void> addCustomNetwork(NetworkTemplate networkTemplate) async {
    if( state.all.any((element) => element.compareUri(networkTemplate.interxUrl))) {
      return;
    }
    NetworkStatus networkStatus = NetworkStatus(
      name: networkTemplate.name,
      interxUrl: networkTemplate.interxUrl,
      status: NetworkStatusType.connecting,
      custom: networkTemplate.custom,
    );
    emit(state.copyWith(availableNetworks: [...state.availableNetworks, networkStatus]));
    refreshNetworkStatus(networkStatus);
  }

  Future<void> removeCustomNetwork(Uri uri) async {
    List<NetworkStatus> availableNetworks = state.availableNetworks.where((e) => !e.compareUri(uri)).toList();
    emit(state.copyWith(availableNetworks: availableNetworks));
  }

  void connect(NetworkStatus networkStatus) {
    emit(state.copyWith(currentNetwork: networkStatus));
    networkStatusNotifier.notifyChanged(networkStatus);
  }

  Future<void> connectX(Uri newUri) async {
    List<NetworkStatus> allNetworks = state.all;
    NetworkStatus networkStatus;
    List<NetworkStatus> availableNetworks;
    try {
      networkStatus = allNetworks.firstWhere((e) => e.compareUri(newUri));
      availableNetworks = allNetworks.where((e) => !e.compareUri(newUri)).toList();
    } catch (e) {
      networkStatus = await networkService.getStatusForNetwork(NetworkTemplate(interxUrl: newUri));
      availableNetworks = allNetworks;
    }

    emit(state.copyWith(currentNetwork: networkStatus, availableNetworks: availableNetworks));
    networkStatusNotifier.notifyChanged(networkStatus);
  }

  void refreshAll() {
    List<NetworkStatus> networksToUpdate = state.all;
    for (NetworkStatus networkStatus in networksToUpdate) {
      refreshNetworkStatus(networkStatus);
    }
  }

  Future<void> refreshNetworkStatus(NetworkStatus networkStatus) async {
    NetworkStatus updatedNetworkStatus = await networkService.getStatusForNetwork(networkStatus.networkTemplate);
    if (networkStatus.compareUri(state.currentNetwork?.interxUrl)) {
      emit(state.copyWith(currentNetwork: updatedNetworkStatus));
      networkStatusNotifier.notifyRefreshed(updatedNetworkStatus);
    } else {
      List<NetworkStatus> updatedNetworkStatuses = state.availableNetworks.map((e) {
        return e.compareUri(networkStatus.interxUrl) ? updatedNetworkStatus : e;
      }).toList();

      emit(state.copyWith(availableNetworks: updatedNetworkStatuses));
    }
  }
}
