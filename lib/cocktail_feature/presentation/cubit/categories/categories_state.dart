import 'package:equatable/equatable.dart';

import '../../../domain/entity/category.dart';

abstract class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object> get props => [];
}

class Empty extends CategoriesState {}

class Loading extends CategoriesState {}

class CategoriesLoaded extends CategoriesState {
  const CategoriesLoaded({required this.categories});

  final List<CategoryDrink> categories;
}

class Error extends CategoriesState {
  const Error({required this.message});

  final String message;
}