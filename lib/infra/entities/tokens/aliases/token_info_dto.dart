import 'package:equatable/equatable.dart';

class TokenInfoDto extends Equatable {
  final String addressPrefix;
  final String defaultDenom;

  const TokenInfoDto({
    required this.addressPrefix,
    required this.defaultDenom,
  });

  @override
  List<Object?> get props => [addressPrefix, defaultDenom];
}