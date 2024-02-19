class NetworkUtils {
  /// Determines whether a proxy should be used based on the application's
  /// and the backend's URI schemes and whether the application URI is a
  /// localhost or private network address.
  ///
  /// This method checks the scheme of the given [backendUri] against the
  /// application's hosting environment [appUri]. If the application is hosted
  /// over HTTPS (and not on a localhost or private network) and the backend URI
  /// uses HTTP, a proxy should be used to ensure secure communication or for
  /// protocol upgrade purposes. However, if the application is hosted on a
  /// localhost or within a private network, there's no need for a proxy,
  /// even if the backend URI uses HTTP.
  ///
  /// - Parameters:
  ///   - appUri: The URI where the application is hosted, used to determine
  ///     the hosting environment and protocol.
  ///   - backendUri: The backend URI, to check if it uses HTTP.
  ///
  /// Returns `true` if a proxy should be used for the given backend URI,
  /// otherwise `false`.
  static bool shouldUseProxy(Uri appUri, Uri backendUri) {
    // No proxy needed for localhost or private 192.168.x.x network addresses
    if (isLocalhost(appUri) || isPrivateNetworkAddress(appUri)) {
      return false;
    }

    // Check if app is served over HTTPS and backend URI is HTTP
    if (appUri.scheme == 'https' && backendUri.scheme == 'http') {
      return true;
    }

    // No proxy needed in other cases
    return false;
  }

  /// Checks if the given [uri] is a localhost address.
  ///
  /// This method identifies if the URI's host part is either 'localhost',
  /// '127.0.0.1', or '::1', which are common representations of the
  /// localhost address.
  ///
  /// Returns `true` if the URI is a localhost address, otherwise `false`.
  static bool isLocalhost(Uri uri) {
    const localhostAddresses = ['localhost', '127.0.0.1', '::1'];
    return localhostAddresses.contains(uri.host);
  }

  /// Checks if the given [uri] falls within the 192.168.x.x address range.
  ///
  /// This method is designed to detect URIs that are part of the
  /// 192.168.0.0/16 subnet, a range commonly used for private networks
  /// within local area networks (LANs).
  ///
  /// Returns `true` if the URI's host part falls within this range,
  /// otherwise `false`.
  static bool isPrivateNetworkAddress(Uri uri) {
    return uri.host.startsWith('192.168.');
  }

  /// Formats a given URI to ensure it follows certain rules regarding scheme,
  /// trailing slashes, port, and host formatting, especially for IPv6 addresses.
  ///
  /// - If no scheme is present, `https` is used as the default.
  /// - Trailing slashes are removed from the path.
  /// - If the URI is not a localhost or an IPv4 address and does not specify a port,
  ///   a default port of 11000 is added.
  /// - IPv6 addresses are properly bracketed if not already.
  ///
  /// @param parsedUrl The original URI to be formatted.
  /// @return A new URI instance with the applied formatting rules.
  static  Uri formatUrl(Uri parsedUrl) {
    // Default to https if no scheme is present
    String scheme = parsedUrl.scheme.isNotEmpty ? parsedUrl.scheme : 'https';

    // Remove trailing slash if present
    String path = parsedUrl.path.endsWith('/') ? parsedUrl.path.substring(0, parsedUrl.path.length - 1) : parsedUrl.path;

    // Adjust host for IPv6 addresses to ensure it's wrapped in brackets
    String host = parsedUrl.host;
    if (isIPv6(parsedUrl) && !host.startsWith('[')) {
      host = '[$host]';
    }

    // Handle port logic
    int? port;
    if (!parsedUrl.hasPort && !isLocalhost(parsedUrl) && !isIPv4(parsedUrl)) {
      // Add default port only if it's not localhost, not an IPv4, and no port is specified
      port = 11000;
    } else {
      // Use the specified port or null to keep the URI's original port
      port = parsedUrl.hasPort ? parsedUrl.port : null;
    }

    // Reconstruct the URI with the adjustments
    return Uri(scheme: scheme, host: host, port: port, path: path);
  }

  /// Checks if the given URI's host is an IPv4 address.
  ///
  /// @param uri The URI to check.
  /// @return `true` if the host is an IPv4 address, otherwise `false`.
  static bool isIPv4(Uri uri) {
    return RegExp(r'^\d{1,3}(\.\d{1,3}){3}$').hasMatch(uri.host);
  }

  /// Checks if the given URI's host is an IPv6 address. This method
  /// is improved to more accurately detect IPv6 addresses by ensuring
  /// the presence of colons and absence of IPv4-like patterns.
  ///
  /// @param uri The URI to check.
  /// @return `true` if the host is an IPv6 address, otherwise `false`.
  static bool isIPv6(Uri uri) {
    // This checks for the presence of colons, indicating an IPv6, but not in a simplistic IPv4 pattern
    return uri.host.contains(':') && !RegExp(r'^\d+\.\d+\.\d+\.\d+$').hasMatch(uri.host);
  }
}
