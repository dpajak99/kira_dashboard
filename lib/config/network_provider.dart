import 'package:dio/browser.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:kira_dashboard/config/predefined_networks.dart';

class NetworkProvider extends ValueNotifier<Uri> {
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

  Dio get httpClient {
    print('Current value: $value');
    Dio baseHttpClient = DioForBrowser(BaseOptions(baseUrl: value.toString()));
    baseHttpClient.interceptors.add(DioCacheInterceptor(options: options));
    return baseHttpClient;
  }

  NetworkProvider() : super(PredefinedNetworks.defaultNetwork.interxUrl);
}
