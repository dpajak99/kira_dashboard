import 'package:equatable/equatable.dart';

class PageState extends Equatable {
  final bool isLoading;

  const PageState({
    required this.isLoading,
  });

  @override
  List<Object?> get props => <Object?>[isLoading];
}
