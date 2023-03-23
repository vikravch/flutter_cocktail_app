import 'package:equatable/equatable.dart';

class CategoryDrink extends Equatable{
  final String name;

  const CategoryDrink({required this.name});

  @override
  List<Object?> get props => [name];

}