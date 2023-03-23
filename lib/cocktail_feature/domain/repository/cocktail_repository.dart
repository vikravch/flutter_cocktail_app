import 'package:dartz/dartz.dart';
import 'package:test_new_project/cocktail_feature/domain/entity/category.dart';

import '../../../core/error/failures.dart';
import '../entity/cocktail.dart';

abstract class CocktailRepository{
  Future<Either<Failure, Cocktail>> getRandomCocktail();
  Future<Either<Failure, List<CategoryDrink>>> getCategories();
  Future<Either<Failure, List<Cocktail>>> getCocktailsByCategory(String category);
}
