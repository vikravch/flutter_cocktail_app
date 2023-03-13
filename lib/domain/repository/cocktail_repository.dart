import 'package:test_new_project/domain/entity/cocktail.dart';

abstract class CocktailRepository{
  Future<Cocktail> getRandomCocktail();
}
