import 'package:equatable/equatable.dart';

class FavouriteAddress extends Equatable {
  final String address;
  final DateTime date;

  const FavouriteAddress({
    required this.address,
    required this.date,
  });

  @override
  List<Object> get props => [address, date];
}
