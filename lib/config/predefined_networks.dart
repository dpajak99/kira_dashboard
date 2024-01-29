import 'package:equatable/equatable.dart';

class PredefinedNetworks {
  static NetworkTemplate get defaultNetwork => networks[1];

  static List<NetworkTemplate> networks = [
    NetworkTemplate(
      name: 'Kira Chaosnet',
      interxUrl: Uri.parse('http://148.251.69.56:11000'),
    ),
    NetworkTemplate(
      name: 'Kira Devnet',
      interxUrl: Uri.parse('http://89.128.117.28:11000/'),
    ),
    NetworkTemplate(
      name: 'Kira Localnet',
      interxUrl: Uri.parse('http://localhost:11000'),
    ),
  ];
}

class NetworkTemplate extends Equatable {
  final String name;
  final Uri interxUrl;

  const NetworkTemplate({
    required this.name,
    required this.interxUrl,
  });

  @override
  List<Object?> get props => [name, interxUrl];
}
