import 'package:equatable/equatable.dart';

class PredefinedNetworks {
  static NetworkTemplate chaosnet = NetworkTemplate(
    name: 'Chaosnet',
    interxUrl: Uri.parse('http://148.251.69.56:11000'),
  );

  static NetworkTemplate devnet = NetworkTemplate(
    name: 'Devnet',
    interxUrl: Uri.parse('http://89.128.117.28:11000/'),
  );

  static NetworkTemplate localnet = NetworkTemplate(
    name: 'Localnet',
    interxUrl: Uri.parse('http://localhost:11000'),
  );

  static NetworkTemplate private = NetworkTemplate(
    name: 'Private',
    interxUrl: Uri.parse('http://192.168.88.177:11000'),
  );

  static NetworkTemplate get defaultNetwork => private;

  static List<NetworkTemplate> networks = [chaosnet, devnet, private];
}

class NetworkTemplate extends Equatable {
  final String? name;
  final bool custom;
  final Uri interxUrl;

  const NetworkTemplate({
    required this.interxUrl,
    this.custom = false,
    this.name,
  });

  @override
  List<Object?> get props => [name, interxUrl];
}
