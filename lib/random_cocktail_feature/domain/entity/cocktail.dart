import 'package:equatable/equatable.dart';

class Cocktail extends Equatable {
  final String id;
  final String name;

  const Cocktail({
    required this.id,
    required this.name,
  });

  @override
  List<Object> get props => [id, name];
}