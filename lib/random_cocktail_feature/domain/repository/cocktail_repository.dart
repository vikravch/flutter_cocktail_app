import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../entity/cocktail.dart';

abstract class CocktailRepository{
  Future<Either<Failure, Cocktail>> getRandomCocktail();
}
