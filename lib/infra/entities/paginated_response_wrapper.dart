import 'package:equatable/equatable.dart';

class PaginatedResponseWrapper<T> extends Equatable {
  final int total;
  final List<T> items;

  const PaginatedResponseWrapper({
    required this.total,
    required this.items,
  });

  @override
  List<Object> get props => [total, items];
}
