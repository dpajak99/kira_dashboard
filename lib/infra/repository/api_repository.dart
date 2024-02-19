import 'package:dio/browser.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/pages/dialogs/network_dialog/network_list_cubit.dart';
import 'package:kira_dashboard/pages/dialogs/network_dialog/network_status.dart';
import 'package:kira_dashboard/utils/network_utils.dart';

abstract class ApiRepository {
  static const String proxyUrl = "https://cors.kira.network/";

  final CacheOptions options = CacheOptions(
    store: HiveCacheStore(null),

    policy: CachePolicy.forceCache,
    // Default.
    // policy: CachePolicy.request,
    // Returns a cached response on error but for statuses 401 & 403.
    // Also allows to return a cached response on network errors (e.g. offline usage).
    // Defaults to [null].
    hitCacheOnErrorExcept: [401, 403],
    // Overrides any HTTP directive to delete entry past this duration.
    // Useful only when origin server has no cache config or custom behaviour is desired.
    // Defaults to [null].
    maxStale: const Duration(seconds: 10),
    // Default. Allows 3 cache sets and ease cleanup.
    priority: CachePriority.normal,
    // Default. Body and headers encryption with your own algorithm.
    cipher: null,
    // Default. Key builder to retrieve requests.
    keyBuilder: CacheOptions.defaultCacheKeyBuilder,
    // Default. Allows to cache POST requests.
    // Overriding [keyBuilder] is strongly recommended when [true].
    allowPostMethod: false,
  );

  Dio getCustomHttpClient(Uri uri) {
    String networkUrl = uri.toString();
    bool useProxy = NetworkUtils.shouldUseProxy(Uri.base, uri);
    if (useProxy) {
      networkUrl = proxyUrl + networkUrl;
    }

    return DioForBrowser(BaseOptions(baseUrl: networkUrl));
  }

  Dio get httpClient {
    NetworkListCubit networkListCubit = getIt<NetworkListCubit>();
    NetworkStatus currentNetwork = networkListCubit.state.currentNetwork!;

    String networkUrl = currentNetwork.interxUrl.toString();
    if (currentNetwork.proxyEnabled) {
      networkUrl = proxyUrl + networkUrl;
    }

    Dio baseHttpClient = DioForBrowser(BaseOptions(baseUrl: networkUrl));
    baseHttpClient.interceptors.add(DioCacheInterceptor(options: options));
    return baseHttpClient;
  }
}
