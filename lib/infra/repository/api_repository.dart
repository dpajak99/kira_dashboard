import 'package:dio/dio.dart';
import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/config/network_provider.dart';

abstract class ApiRepository {
  Dio get httpClient => getIt<NetworkProvider>().httpClient;
}