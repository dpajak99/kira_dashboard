import 'package:equatable/equatable.dart';

class PaginatedRequest extends Equatable {
  final int limit;
  final int offset;

  const PaginatedRequest({
    required this.limit,
    required this.offset,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'limit': limit,
      'offset': offset,
      'count_total': true,
    };
  }

  @override
  List<Object?> get props => <Object?>[limit, offset];
}