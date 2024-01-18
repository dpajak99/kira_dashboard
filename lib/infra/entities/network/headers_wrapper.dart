import 'package:kira_dashboard/infra/entities/network/interx_headers.dart';

class HeadersWrapper<T> {
  final T data;
  final InterxHeaders headers;

  HeadersWrapper({
    required this.data,
    required this.headers,
  });
}