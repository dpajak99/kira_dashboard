import 'package:equatable/equatable.dart';
import 'package:kira_dashboard/infra/entities/transactions/out/transaction/components/mode_info/sign_mode.dart';

class SingleModeInfo extends Equatable {
  final SignMode mode;

  const SingleModeInfo({
    required this.mode,
  });

  factory SingleModeInfo.fromJson(Map<String, dynamic> json) {
    return SingleModeInfo(mode: SignMode.values.firstWhere((SignMode e) => e.name == json['mode']));
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'mode': mode.name,
      };

  @override
  List<Object?> get props => <Object?>[mode];
}
