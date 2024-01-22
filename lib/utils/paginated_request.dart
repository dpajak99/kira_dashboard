import 'package:equatable/equatable.dart';

class PaginatedRequest extends Equatable {
  final int limit;
  final int offset;

  const PaginatedRequest({
    required this.limit,
    required this.offset,
  });

  Map<String, int> toJson() {
    return <String, int>{
      'limit': limit,
      'offset': offset,
    };
  }

  @override
  List<Object?> get props => <Object?>[limit, offset];
}