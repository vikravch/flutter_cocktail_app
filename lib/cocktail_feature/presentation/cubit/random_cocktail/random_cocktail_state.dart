import 'package:equatable/equatable.dart';

import '../../../domain/entity/cocktail.dart';


abstract class RandomCocktailState extends Equatable {
  const RandomCocktailState();

  @override
  List<Object> get props => [];
}

class Empty extends RandomCocktailState {}

class Loading extends RandomCocktailState {}

class RandomCocktailLoaded extends RandomCocktailState {
  const RandomCocktailLoaded({required this.cocktail});

  final Cocktail cocktail;
}

class Error extends RandomCocktailState {
  const Error({required this.message});

  final String message;
}