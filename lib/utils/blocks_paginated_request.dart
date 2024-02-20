import 'package:equatable/equatable.dart';

class BlocksPaginatedRequest extends Equatable {
  final int maxHeight;
  final int minHeight;

  const BlocksPaginatedRequest({
    required this.maxHeight,
    required this.minHeight,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'maxHeight': maxHeight,
      'minHeight': minHeight < 0 ? 0 : minHeight,
    };
  }

  @override
  List<Object?> get props => <Object?>[maxHeight, minHeight];
}